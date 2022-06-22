```
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube
```

```
yum groupinstall "Virtualization Host"
systemctl enable --now libvirtd
useradd minikube -g wheel
usermod -a -G libvirt minikube
newgrp libvirt
```

Uncomment lines in `vi /etc/libvirt/libvirtd.conf`

```
unix_sock_group = "libvirt"
unix_sock_rw_perms = "0770"
```

```
systemctl restart libvirtd.service
```

https://minikube.sigs.k8s.io/docs/start/