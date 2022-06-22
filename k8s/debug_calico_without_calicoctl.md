While you can debug Calico and the Bird mesh with `calicoctl`, sometimes this
isn't an option. 

For these cases refer to the below commands: 

### Mesh status
```shell
/bin/birdcl -s /var/run/calico/bird.ctl

/bin/birdcl -s /var/run/calico/bird.ctl show protocol
```