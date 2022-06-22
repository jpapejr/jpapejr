With some minor modifications, you can tell your Mac to use TouchID as a form of authentication for `sudo`.

If you edit `/etc/pam.d/sudo` and add the following line to the top:

```
auth sufficient pam_tid.so
```

You can now use your fingerprint to `sudo`!


Reference -> https://twitter.com/cabel/status/931292107372838912