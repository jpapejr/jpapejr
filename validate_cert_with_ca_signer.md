To confirm if a given TLS certificate is signed by a given Certificate Authority (ca):

```
openssl verify -verbose -CAfile cacert.pem  server.crt
```