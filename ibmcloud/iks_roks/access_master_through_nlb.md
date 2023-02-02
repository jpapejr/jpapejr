Use the following YAML to create a VPC NLB that will allow access to the OpenShift master and 
OAuth server endpoint via the private cloud service endpoint

```
apiVersion: v1
kind: Service
metadata:
  name: oc-api-via-nlb
  annotations:
    service.kubernetes.io/ibm-load-balancer-cloud-provider-ip-type: private
  namespace: default
spec:
  type: LoadBalancer
  ports:
  - name: apiserver
    protocol: TCP
    port: <master endpoint port found in cluster overview data>
    targetPort: <master endpoint port found in cluster overview data>
  - name: oauth
    protocol: TCP
    port: <oauth port discovered with footnote below>
    targetPort: <oauth port discovered with footnote below>
---
kind: Endpoints
apiVersion: v1
metadata:
  name: oc-api-via-nlb
  namespace: default
subsets:
  - addresses:
      - ip: 172.20.0.1
    ports:
      - name: apiserver
        port: 2040
  - addresses:
      - ip: 166.9.30.22
      - ip: 166.9.32.20
      - ip: 166.9.28.43
    ports:
      - name: oauth
        port: <oauth port discovered with footnote below>
```

Finding your OAuth port:

```
curl -sk -XGET  -H "X-Csrf-Token: 1" 'https://<master service endpoint>/.well-known/oauth-authorization-server' | grep token_endpoint
```




