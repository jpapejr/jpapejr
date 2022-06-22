* Reference https://marcusnoble.co.uk/2021-09-01-migrating-from-docker-to-podman/
* Networking details https://www.redhat.com/sysadmin/container-networking-podman
* Command reference https://docs.podman.io/en/latest/Commands.html

## Enable dns in podman network

1. Edit /var/home/core/.config/cni/net.d/87-podman.conflist
2. Add 

``` json
{
   "type": "dnsname",
   "domainName": "dns.podman",
   "capabilities": {
      "aliases": true
   }
}
```

3. Exit the SSH session and `podman machine stop` followed by `podman machine start`


## Set another network as default
1. `podman machine ssh`
2. Add new heading below to /etc/containers/containers.conf (e.g. `sudo vi /etc/containers/containers.conf`)

``` 
[network]
default_network="<network name here>"
```

3. Exit the SSH session and `podman machine stop` followed by `podman machine start`
