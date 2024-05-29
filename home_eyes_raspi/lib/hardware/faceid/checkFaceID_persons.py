import base64
from datetime import datetime
import json
import re
import sys
import uuid
from PIL import Image
from picamera2 import Picamera2
import time
import boto3
import os
from doorLock import unlock_door, lock_door
from readCard import readCard, checkCard
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import io
from addLockStatus import run

directory = '/home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/lib/hardware/faceid/PiPhotos'

P = Picamera2()
camera_config = P.create_still_configuration(main={"size": (1920, 1080)}, lores={"size": (640, 480)}, display="lores")
P.configure(camera_config)
P.start()
stream = io.BytesIO()

# Parameters
host = "ahmq9yzoz5hrd-ats.iot.us-east-1.amazonaws.com"
rootCAPath = "/home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/assets/certs/CA1.pem"
certificatePath = "/home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/assets/certs/certificate.pem.crt"
privateKeyPath = "/home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/assets/certs/private.pem.key"

# Init AWSIoTMQTTClient
myMQTTClient = AWSIoTMQTTClient("")
myMQTTClient.configureEndpoint(host, 8883)
myMQTTClient.configureCredentials(rootCAPath, privateKeyPath, certificatePath)

# AWS IoT policy permissions must allow connect, publish, subscribe
if myMQTTClient.connect():
    print("Connected to AWS IoT Core")
else:
    print("Failed to connect to AWS IoT Core")

rek_client = boto3.client('rekognition',
                        region_name='us-east-1'
                        )
s3_client = boto3.client('s3',
                        region_name='us-east-1'
                        )

def add_log_unlock_door(username, action):
    # Generate a random string for Id
    id_str = str(uuid.uuid4())

    
    # Get the current time
    current_time = datetime.now().strftime('%Y-%m-%dT%H:%M:%S')
    
    # Log to DynamoDB
    try:
        dynamodb = boto3.resource('dynamodb', region_name='us-east-1')
        table = dynamodb.Table('logs-unlocks')
        table.put_item(
            Item={
                'logsId': id_str,
                'username': username,
                'action': action,
                'timestamp': current_time
            }
        )
        print("Logged unlock action to DynamoDB")
    except Exception as e:
        print(f"Error logging to DynamoDB: {e}")


def clear_jpg_files(folder_path):
    if not os.path.exists(folder_path):
        print("Folder does not exist.")
        return
    
    for filename in os.listdir(folder_path):
        file_path = os.path.join(folder_path, filename)
        
        if os.path.isfile(file_path) and file_path.endswith('.jpg'):
            try:
                os.unlink(file_path)
                print(f"Deleted {file_path}")
            except Exception as e:
                print(f'Failed to delete {file_path}. Reason: {e}')
        else:
            print(f'Skipped {file_path}')

def                                                                                                                                                                                                                                                 send_sms_message(phone_number, message):
    sns_client = boto3.client('sns', region_name='us-east-1')  # Adjust the region as needed
    response = sns_client.publish(
        PhoneNumber=phone_number,
        Message=message
    )
    print(response)
    return response

def check_camera(phone):
    time.sleep(2)  # Wait for the camera to stabilize
    milli = int(round(time.time() * 1000))  # Get the current time in milliseconds
    image_path = '{}/image_{}.jpg'.format(directory, milli)  # Create a unique image path
    
    P.capture_file(image_path)  # Capture an image and save it to the file

    with Image.open(image_path) as img:
        img = img.resize((640, 480), Image.LANCZOS)  # Resize the image to 640x480
        img.save(image_path, "JPEG", quality=50)  # Save the resized image

    with open(image_path, 'rb') as image_file:
        try:
            image_bytes = image_file.read()  # Read the image file as bytes
            image_base64 = base64.b64encode(image_bytes).decode('utf-8')  # Encode image to base64
            payload = json.dumps({"image_base64": image_base64})  # Create a JSON payload
            # print(f"Publishing payload: {payload}")
            result = myMQTTClient.publish("pi/camera/stream", payload, 0)  # Publish the payload to MQTT
            
            if result:
                print("Message published successfully")
            else:
                print("Failed to publish message")
            
            match_response = rek_client.search_faces_by_image(CollectionId=collectionId, 
                                                              Image={'Bytes': image_bytes}, 
                                                              MaxFaces=1, FaceMatchThreshold=85)
            if match_response['FaceMatches']:
                
                matched_face = match_response['FaceMatches'][0]
                external_image_id = matched_face['Face']['ExternalImageId']
                unlock_door()  # Unlock the door if a face match is found
                add_log_unlock_door(collectionId, "camera unlock")
                print('unlocked')
                match = re.match(r'(\w+)_(\w+)\.jpg', external_image_id)
                if match:
                    firstname = match.group(1).capitalize()
                    last_initial = match.group(2).upper()
                    formatted_name = f"{firstname} {last_initial}"
                payload = f"Person detected at front door. Identity known: {external_image_id} "  # Create a JSON payload
                send_sms_message(phone, payload)
            else:
                print('No faces matched')
                payload = "Person detected at front door. Identity not known."  # Create a JSON payload
                send_sms_message(phone, payload)
        except Exception as e:
            print('Error:', e)
                
    time.sleep(3)  # Wait for 3 seconds before locking the door
    lock_door()  # Lock the door
    clear_jpg_files(directory)  # Clear the captured image files


def check_rfid(collectionId):
    key = f"public/{collectionId}/cards.txt"
    bucket_name = "homeeyes315d1baa694e48c78584a098ef41739d391b4-homeeyes"
    #print(key)
    
    try:
        # Download the file from S3
        result = s3_client.get_object(Bucket=bucket_name, Key=key)
        file_content = result['Body'].read().decode('utf-8')
        card_ids = file_content.split('\n')
        
        # Get the UID from the checkCard function
        uid = checkCard()
        
        # Check if the UID is in the list of card IDs
        if uid in card_ids:
            print(f"UID {uid} is authorized.")
            unlock_door()
            
            payload = f"Door unlocked with card No: {uid}."  # Create a JSON payload
            send_sms_message(phone, payload)
            add_log_unlock_door(collectionId, "card unlock")
            time.sleep(3)
            lock_door()

        elif uid != 0:
            payload = f"Door tried to be unlocked. Card No: {uid} is not authorized."  # Create a JSON payload
            send_sms_message(phone, payload)
            print(f"UID {uid} is not authorized.")
            lock_door()
        else:
            print("Unhandled condition for UID.")
    except Exception as e:
        print(f"Error: {e}")
        

def check_door(collectionId):
    key = f"public/{collectionId}/doorlock.txt"
    print(f"Checking door lock status for collectionId: {collectionId}")
    print(f"Constructed S3 key: {key}")
    bucket_name = "homeeyes315d1baa694e48c78584a098ef41739d391b4-homeeyes"

    try:
        response = s3_client.get_object(Bucket=bucket_name, Key=key)
        file_content = response['Body'].read().decode('utf-8')
        print(f"Door lock file content: {file_content}")

        if 'ReadCard' in file_content:
            readCard(collectionId)

        if 'unlock' in file_content:
            unlock_door()
            run(collectionId, "lock") #write to lock after the command from file was done
            payload = f"Door unlocked manually from app."  # Create a JSON payload
            send_sms_message(phone, payload)
            add_log_unlock_door(collectionId, "manual unlock")
            print('Door unlocked based on doorlock.txt')
        else:
            lock_door()
            print('Door locked based on doorlock.txt')
    except Exception as e:
        print(f"Error reading doorlock file: {e}")


def match_residents(collectionId, phone):
    while True:
        check_camera(phone)
        check_rfid(collectionId)
        check_door(collectionId)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python script.py <collection_id> <phone_number>")
        sys.exit(1)
        
    collectionId = sys.argv[1]
    phone = sys.argv[2]
    lock_door()
    match_residents(collectionId, phone)
