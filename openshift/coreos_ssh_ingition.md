# Configure an SSH service account for CoreOS workers


```
  "passwd": {
    "users": [
        {
            "name": "core",
            "sshAuthorizedKeys": [
              "ssh-rsa <ssh-key>"
            ]
        },
        {
            "name": "sigex",
            "passwordHash": "<password-hash>",
            "groups": [ "wheel", "sudo"],
            "sshAuthorizedKeys": [
                "ssh-rsa <ssh-key>"
            ]
        }
    ]
},
```
