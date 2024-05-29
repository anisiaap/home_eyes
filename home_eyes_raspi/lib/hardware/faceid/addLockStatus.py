import boto3
import sys
import tempfile
import os

def create_temp_file(content):
    """Creates a temporary file with the given content and returns its path."""
    temp = tempfile.NamedTemporaryFile(delete=False)
    try:
        temp.write(content.encode('utf-8'))
        temp.flush()
        return temp.name
    finally:
        temp.close()

def upload_to_s3(s3_client, file_path, bucket_name, key):
    """Uploads a file to AWS S3."""
    try:
        s3_client.upload_file(file_path, bucket_name, key)
        print(f"Upload to S3 successful: {key}")
    except Exception as e:
        print(f"Failed to upload to S3: {e}")

def run(user, action):
    bucket_name = 'homeeyes315d1baa694e48c78584a098ef41739d391b4-homeeyes'
    key = f'public/{user}/doorlock.txt'

    # Initialize S3 client
    s3_client = boto3.client('s3',
                             region_name='us-east-1')

    # Create the new content
    new_content = action

    # Create a temporary file with the new content
    temp_file_path = create_temp_file(new_content)

    # Upload the file to S3
    upload_to_s3(s3_client, temp_file_path, bucket_name, key)

    # Clean up the temporary file
    os.remove(temp_file_path)

def main():
    if len(sys.argv) != 3:
        print("Usage: python addLockStatus.py <user> <action>")
        return

    user = sys.argv[1]
    action = sys.argv[2]

    run(user, action)

if __name__ == "__main__":
    main()
