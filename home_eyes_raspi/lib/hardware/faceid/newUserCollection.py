import sys
import boto3

def create_collection(collection_id):
    rekognition = boto3.client('rekognition', region_name='us-east-1')
    
    try:
        rekognition.create_collection(CollectionId=collection_id)
        print(f"Collection '{collection_id}' created successfully.")
    except rekognition.exceptions.ResourceAlreadyExistsException:
        print(f"Collection '{collection_id}' already exists.")
    except Exception as e:
        print(f"Error creating collection: {e}")

if __name__ == "__main__":
    if len(sys.argv) != 2:
        print("Usage: python script.py <collection_id>")
        sys.exit(1)
        
    collection_id = sys.argv[1]
    create_collection(collection_id)
