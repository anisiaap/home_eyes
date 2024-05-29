import boto3
import MFRC522
import signal
from botocore.exceptions import NoCredentialsError

# Initialize the S3 client
s3_client = boto3.client('s3',
                         region_name='us-east-1'
                         )

# Set your bucket name
bucket_name = ""


# Function to convert UID to string
def uidToString(uid):
    return ''.join(format(i, '02X') for i in uid)

# Capture SIGINT for cleanup when the script is aborted
def end_read(signal, frame):
    global continue_reading
    print("Ctrl+C captured, ending read.")
    continue_reading = False

# Hook the SIGINT
signal.signal(signal.SIGINT, end_read)

# Create an object of the class MFRC522
MIFAREReader = MFRC522.MFRC522()

def writeToFileUid(user, uids):
    file_path = f'public/{user}/cards.txt'
    try:
        # Check if the file exists
        try:
            s3_client.head_object(Bucket=bucket_name, Key=file_path)
            file_exists = True
        except s3_client.exceptions.ClientError as e:
            if e.response['Error']['Code'] == "404":
                file_exists = False
            else:
                raise
        
        if file_exists:
            # If the file exists, read its content
            obj = s3_client.get_object(Bucket=bucket_name, Key=file_path)
            current_data = obj['Body'].read().decode('utf-8')
            new_data = f"{current_data}\n{uids}"
        else:
            # If the file does not exist, create it
            new_data = uids

        # Upload the new data to S3
        s3_client.put_object(Bucket=bucket_name, Key=file_path, Body=new_data.encode('utf-8'))
        print(f"UID {uids} written to {file_path}")
    
    except NoCredentialsError:
        print("Credentials not available")

# Function to read the card and write UID to S3
def readCard(user):
    # Scan for cards
    (status, TagType) = MIFAREReader.MFRC522_Request(MIFAREReader.PICC_REQIDL)
    # If a card is found
    if status == MIFAREReader.MI_OK:
        print("Card detected")
        # Get the UID of the card
        (status, uid) = MIFAREReader.MFRC522_SelectTagSN()
        # If we have the UID, continue
        if status == MIFAREReader.MI_OK:
            uids = uidToString(uid)
            print(f"Card read UID: {uids}")
            writeToFileUid(user, uids)
        else:
            print("Authentication error")

def checkCard():
    # Scan for cards
    (status, TagType) = MIFAREReader.MFRC522_Request(MIFAREReader.PICC_REQIDL)
    # If a card is found
    if status == MIFAREReader.MI_OK:
        print("Card detected")
        # Get the UID of the card
        (status, uid) = MIFAREReader.MFRC522_SelectTagSN()
        # If we have the UID, continue
        if status == MIFAREReader.MI_OK:
            uids = uidToString(uid)
            print(f"Card read UID: {uids}")
            return uids
        else:
            print("Authentication error")
    return 0