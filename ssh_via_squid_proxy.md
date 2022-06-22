Add the following to your `~/.ssh/config` file:

``` 
Host *
    ProxyCommand          nc -X connect -x <proxy_host>:<proxy_port> %h %p
    ServerAliveInterval   10
```

>Note: you can sub any hostname or IP in place of the `*` above. 
