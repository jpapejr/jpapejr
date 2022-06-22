```
curl -X "PUT" "https://s3.us-east.cloud-object-storage.appdomain.cloud/<bucket>/<file>" -H "x-amz-acl: public-read" -H "Authorization: Bearer $(ibmcloud iam oauth-tokens | cut -d' ' -f5)" --data-binary "@</path-to-file.txt"
```

> Note: this example uploads objects as `public-read` which is internet visible. 