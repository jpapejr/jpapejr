MicroK8s doesn't allow privileged deployments to run on the cluster by default. To fix: 

Add `--allow-privileged` into `/var/snap/microk8s/current/args/kube-apiserver` and `microk8s.stop; microk8s.start` to resolve it.