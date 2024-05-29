import asyncio
import json
import websockets
from AWSIoTPythonSDK.MQTTLib import AWSIoTMQTTClient
import logging
import threading

# Set up logging
logging.basicConfig(level=logging.DEBUG)
logger = logging.getLogger(__name__)

# AWS IoT Core configuration
host = "ahmq9yzoz5hrd-ats.iot.us-east-1.amazonaws.com"
rootCAPath = "/home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/assets/certs/CA1.pem"
certificatePath = "/home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/assets/certs/certificate.pem.crt"
privateKeyPath = "/home/anisiapirvulescu/Desktop/HomeEyes/home_eyes/assets/certs/private.pem.key"
topic = "pi/camera/stream"

# WebSocket server configuration
websocket_server_host = "localhost"
websocket_server_port = 8765

# Init AWSIoTMQTTClient
myMQTTClient = AWSIoTMQTTClient("iotconsole")
myMQTTClient.configureEndpoint(host, 8883)
myMQTTClient.configureCredentials(rootCAPath, privateKeyPath, certificatePath)

# Global WebSocket connection
websocket_connection = None

async def handle_websockets(websocket, path):
    global websocket_connection
    websocket_connection = websocket
    logger.debug("WebSocket client connected")
    async for message in websocket:
        logger.debug(f"Received message from client: {message}")

async def start_websocket_server():
    async with websockets.serve(handle_websockets, websocket_server_host, websocket_server_port):
        await asyncio.Future()  # Run forever

def on_message(client, userdata, message):
    try:
        # Decode the message payload
        payload = message.payload.decode('utf-8')
        data = json.loads(payload)
        image_base64 = data.get("image_base64")
        
        if image_base64:
            logger.debug("Received image via MQTT")
            # Send the image via WebSocket
            asyncio.run(send_image_via_websocket(image_base64))
        else:
            logger.error("No image found in the payload")
    except Exception as e:
        logger.error(f"Error processing message: {e}")

async def send_image_via_websocket(image_base64):
    global websocket_connection
    if websocket_connection:
        await websocket_connection.send(image_base64)
        logger.debug("Image sent via WebSocket")
    else:
        logger.error("No WebSocket connection available")

if __name__ == "__main__":
    # Connect to AWS IoT Core
    if myMQTTClient.connect():
        logger.debug("Connected to AWS IoT Core")
    else:
        logger.error("Failed to connect to AWS IoT Core")
    
    # Subscribe to the topic
    myMQTTClient.subscribe(topic, 1, on_message)
    logger.debug(f"Subscribed to topic {topic}")
    # Start the WebSocket server
    try:
        asyncio.run(start_websocket_server())
    except KeyboardInterrupt:
        logger.debug("WebSocket server stopped")
