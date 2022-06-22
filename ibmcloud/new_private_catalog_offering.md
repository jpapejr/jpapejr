To add a new offering to an existing private catalog on IBM Cloud, issue the following `curl` command:


```
curl -s -g -H "Authorization: Bearer $(ibmcloud iam oauth-tokens | cut -d' ' -f5)" -location -request POST "https://cm.globalcatalog.cloud.ibm.com/api/v1-beta/catalogs/<CATALOG ID>/offerings" -H 'Content-Type: application/json' --data "@offering.json" -vvv
```

After a successful POST request, you'll have a new offering in the catalog to use!