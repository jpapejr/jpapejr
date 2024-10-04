import os
import ibm_boto3
from ibm_botocore.client import Config, ClientError

# IBM Cloud Object Storage Credentials
COS_ENDPOINT = "https://s3.direct.us-south.cloud-object-storage.appdomain.cloud"  # Replace with your COS endpoint
COS_API_KEY_ID = "secret"  # Replace with your API key
COS_INSTANCE_CRN = "crn here"  # Replace with your instance CRN
BUCKET_NAME = "mybucket"  # Replace with your bucket name
PREFIX = "codellama-34b-instruct-hf/" # Replace with the desired prefix

# Create a COS resource
cos = ibm_boto3.resource(
    "s3",
    ibm_api_key_id=COS_API_KEY_ID,
    ibm_service_instance_id=COS_INSTANCE_CRN,
    config=Config(signature_version="oauth"),
    endpoint_url=COS_ENDPOINT
)

def upload_files(directory):
    """
    Uploads all files from a specified directory to a COS bucket.
    
    :param directory: Path to the directory containing files
    """
    try:
        # List all files in the directory
        for root, dirs, files in os.walk(directory):
            for file_name in files:
                file_path = os.path.join(root, file_name)
                # Upload file to bucket
                if (file_name == ".git"):
                    print(f"Skipping {file_name}")
                    continue
                print(f"Uploading {PREFIX + file_name} to bucket {BUCKET_NAME}...")
                cos.Object(BUCKET_NAME, PREFIX + file_name).upload_file(Filename=file_path)
                print(f"File {file_name} uploaded successfully.")
    except ClientError as e:
        print(f"Error occurred: {e}")
    except Exception as e:
        print(f"An unexpected error occurred: {e}")

if __name__ == "__main__":
    # Directory path containing the files to upload
    directory = f'./{PREFIX}'  # Replace with your local directory path
    upload_files(directory)