Managed OpenShift on IBM Cloud clusters have 2 management service endpoints per cluster: 1 for the master service endpoint
and one for the OCP OAuth endpoint. The former is easily obtained with `ibmcloud cs cluster get` commands while the other is
more obscure. Use the info below to find this port if you need it for clever proxying solutions sometimes required for private
cluster topologies.

```
curl -sk -XGET  -H "X-Csrf-Token: 1" 'https://<<master service endpoint/.well-known/oauth-authorization-server' | grep token_endpoint
```