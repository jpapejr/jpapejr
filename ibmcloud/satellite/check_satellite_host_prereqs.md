Here's an easy way to check to see if a particular host will likely attach correctly to an IBM Cloud 
Satellite Location successfully:

``` shell
curl https://containers.test.cloud.ibm.com/satellite-health/sat-host-check -o sat-host-check
chmod +x sat-host-check
./sat-host-check --region us-east
```

> where `region` is the location "managed-from" region`
