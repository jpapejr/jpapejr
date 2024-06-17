## Increasing max open files on a RHCOS-based ROKS cluster

> Most of the knowledge below was derived from [here](https://access.redhat.com/solutions/6974793). This is definately the preferred option if you are
> running a cluster with a working MachineConfig Operator. But until ROKS supports that, another solution is needed.


The following changes need to be made. How they get done, is up to you: a simple hack is to modify a single host and hope the workload goes there, a more 
elegant solution would be a daemonset that runs on each host to make the change...


Change value of **fs.nr_open** /etc/sysctl.d/99-sysctl.conf
```
fs.nr_open=1048577
```

Change `default_ulimits` stanza in `/etc/crio/crio.conf` or add a new file in `/etc/crio/crio.conf.d` with this content
```
default_ulimits=[
	"nofile=1048577:1048577",
]
```

**Note**: You may need to increase the value further depending on your needs (e.g. > 1048577


> [!TIP]
> Bear in mind changing this value on the host manually will result in the values getting reset if the managed node is updated or replaced/reloaded!!
