The IBM Cloud Block CSI plugin in VPC gen2 will constantly reconcile the `storageclass` of `ibmc-vpc-block-10iops-tier` as
default. That's great until it isn't. This hack one-liner will nerf that setting for the length of the loop so you can install
workloads that don't easily allow for setting the storage class for required PVCs.


``` bash
while true; do oc annotate sc/ibmc-vpc-block-10iops-tier storageclass.beta.kubernetes.io/is-default-class="false" --overwrite; sleep 2;  done
```