The following config (placed in `~/.gnupg/gpg-agent.conf` will set the agent up to cache the gpg key passphrase
on Mac for 24 hours.

```
pinentry-program /usr/local/bin/pinentry-mac
default-cache-ttl 86400 
max-cache-ttl 86400
```

To restart the gpg-agent do `gpg-connect-agent reloadagent /bye`


> source: https://superuser.com/questions/624343/keep-gnupg-credentials-cached-for-entire-user-session