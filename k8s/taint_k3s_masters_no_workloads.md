Clusters provisioned with `k3sup` or `k3s` don't automatically apply taints to the master nodes and, thus, user workloads can be deployed on master nodes.
This is likey undesireable in most cases so the user must apply some taints to the master nodes in order to prevent workloads from being scheduled. The 
following will accomplish this: 

*At install time*
``` bash
--node-taint k3s-controlplane=true:NoExecute
```

*Post-install*
``` bash
kubectl taint node <master_node_name> k3s-controlplane=true:NoSchedule
```

Since these taints will also prevent the scheduling of the CoreDNS, metrics-server, and local-path-provisioner workloads. To fix this, edit their spec's like so:

``` bash
spec:
  ...
  template:
  ...
    spec:
    ...
      tolerations:
      - effect: NoExecute
        operator: Exists
      - effect: NoSchedule
        operator: Exists
```

> Reference thread from GitHub issue - https://github.com/rancher/k3s/issues/1401