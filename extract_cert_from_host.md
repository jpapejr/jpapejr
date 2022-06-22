``` shell
openssl s_client -connect {HOSTNAME}:{PORT} </dev/null 2>/dev/null|openssl x509 -outform PEM >mycertfile.pem
```

Then import into Keychain (System) when on Mac or whatever you do with it on Windows/Linux.