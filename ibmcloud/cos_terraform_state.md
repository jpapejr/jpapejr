IBM Cloud Object Storage (COS) can be used to store Terraform state in a way that still allows for proper locking and sharing similar 
to what you get with IBM Cloud Schematics and Terraform Cloud. To set this up put this block in your `terraform` section: 


``` 
terraform {
  backend "s3" {
    bucket                      = "jtp-tfstate"
    endpoint                    = "s3.us-east.cloud-object-storage.appdomain.cloud"
    force_path_style            = true
    // Skip calls to AWS S3 API
    skip_region_validation      = true
    skip_credentials_validation = true
    skip_metadata_api_check     = true
    key                         = "terraform.tfstate"
    region                      = "us-east"
    shared_credentials_file     = "credentials.txt"
  }
  required_providers {
    ibm = {
      source  = "IBM-Cloud/ibm"
      version = "1.24.0"
    }
  }
}
```


In `credentials.txt`: 

```
[default]
aws_access_key_id=<your HMAC access key id>
aws_secret_access_key=<your HMAC secret access key> 
```