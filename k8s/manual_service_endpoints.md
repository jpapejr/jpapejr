# Creating manual service endpoints

An example of manually creating endpoints for a service spec. This example allows `service B` in `namespace B` to actually have endpoints from other namespaces (i.e. `service A` in `namespace A`)

```
kind: Service
apiVersion: v1
metadata:
  name: serviceB
  namespace: namespaceB
spec:
  ports:
  - protocol: TCP
    port: <serviceB port>
    targetPort: <serviceA port>
---
kind: Endpoints
apiVersion: v1
metadata:
  name: serviceB
  namespace: namespaceB
subsets:
  - addresses:
    - ip: <serviceA clusterIP>
    ports:
    - port: <serviceA port>
```