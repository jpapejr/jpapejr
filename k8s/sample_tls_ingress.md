# Sample Ingress resource with TLS

```
apiVersion: extensions/v1beta1  
kind: Ingress  
metadata:  
  name: myingressresource  
spec:  
  tls:  
  - hosts:  
    - <domain>  
    secretName: <tls_secret_name>  
  rules:  
  - host: <domain>  
    http:  
      paths:  
      - path: /<app1_path>  
        backend:  
          serviceName: <app1_service>  
          servicePort: 80  
      - path: /<app2_path>  
        backend:  
          serviceName: <app2_service>  
          servicePort: 80
```