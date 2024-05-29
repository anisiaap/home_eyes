import json
import boto3

def handler(event, context):
    # Extract username and email from the event
    email = event['email']
    
    # Construct bucket name
    bucket_name = f'user-{email}-bucket'
    
    # Create S3 client
    s3 = boto3.client('s3')
    
    try:
        # Create S3 bucket
        s3.create_bucket(Bucket=bucket_name)
        
        # Return success response
        return {
            'statusCode': 200,
            'body': json.dumps({
                'message': f'S3 bucket {bucket_name} created successfully'
            })
        }
    except Exception as e:
        # Return error response
        return {
            'statusCode': 500,
            'body': json.dumps({
                'error': str(e)
            })
        }
