OpenShift clusters on IBM Cloud (ROKS) cluster are different that UPI/IPI installed OCP installs in that they do not support
the modification of some cluster global settings. Specifically, there are settings that the MachineConfig Operator deployment would
read and translate into host-level configuration on the workers. One example of this is configuring an HTTP(s) proxy for the cluster. 

Consider this, you have a VPC on IBM Cloud with no public gateways connected to your on-premises network via DirectLink. Thus your private-only ROKS cluster has no path out to the internet to pull container images from except that which you provide via your corporate proxy server. Additionally, cluster operators like the marketplace and samples operator (which populate the OperatorHub and Developer Catalog contents)
need to be able to reach the internet to obtain content as well. Using the steps below, we can configure the proxy for use on all the
worker hosts and for the cluster operators that require it. 

### Step 1 - Configure the cluster-wide proxy settings

To accomplish this, follow [this document](https://docs.openshift.com/container-platform/4.5/networking/enable-cluster-wide-proxy.html#nw-proxy-configure-object_config-cluster-wide-proxy) to configure the `proxy.config.openshift.io/cluster` resource in the cluster. 

After this, you can restart the operators in the `openshift-marketplace` and `openshift-cluster-samples-operator` projects and those 
workloads should be able to access their respective content from operatorhub.io and quay.io. 

### Step 2 - The script

Taking the following example, create a new file with the contents below (I.e. create `proxify.sh`) and ensure it's executable (I.e. `chmod +x ./proxify.sh`): 

- Replace the last three CIDR ranges (I.e. `10.241.128.0/24`, `10.241.64.0/24`, `10.241.0.0/24`) in the `NO_PROXY` field with the CIDR ranges for your VPC subnets. Add more to the end if you have more than 3 subnets in your VPC architecture.
- Replace the `host:port` values in the `HTTP_PROXY` and `HTTPS_PROXY` fields with your proxy's host and port values.

``` bash
set -o xtrace
#!/bin/sh
CLUSTER=$1
for NODE in `oc get no -oname`; do
    echo $NODE
    oc debug $NODE -- /bin/sh -c 'echo NO_PROXY="localhost,cluster.local,.src,127.0.0.1,172.20.0.1,172.21.0.0/16,172.17.0.0/18,161.26.0.0/16,166.8.0.0/14,172.20.0.0/16,10.241.128.0/24,10.241.64.0/24,10.241.0.0/24"  > /host/etc/sysconfig/crio-network;'
    oc debug $NODE -- /bin/sh -c 'echo HTTP_PROXY="http://10.241.0.11:3128/" >> /host/etc/sysconfig/crio-network;'
    oc debug $NODE -- /bin/sh -c 'echo HTTPS_PROXY="http://10.241.0.11:3128/" >> /host/etc/sysconfig/crio-network;'
    oc debug $NODE -- /bin/sh -c 'cat /host/etc/sysconfig/crio-network;'
    oc label $NODE crio-proxified=true; 
done
read -p "Press enter to continue with rolling reboot of workers (15m interval between reboots), or Ctrl-C to exit and manual reboot workers..."
for WORKER in ` ibmcloud cs worker ls --cluster $CLUSTER | grep kube | cut -d' ' -f1`; do
    echo $WORKER
    ibmcloud cs worker reboot -f --skip-master-health --worker $WORKER --cluster $CLUSTER;
    sleep 15m;
done
echo "Proxified nodes:"
oc get nodes -l crio-proxified=true
```


### Step 3 - Run the script
To run the script, simply supply the cluster ID or name (e.g. `./proxify.sh my-cool-cluster`)

The script will connect to each worker node via a debug pod and inject the updated configuration into the `/etc/sysconfig/crio-network` file. A label of `crio-proxified: true` will also be attached to each worker the script updated. After the updates are completed, the script will pause and ask you if you'd like restart all of the workers, in turn, with a 15 minute interval between each restart. If you don't want to do this, simply hit Ctrl-C and abort the script at that time. Then manually restart your workers in the desired way until all updated workers have been restarted. 

Now the workers should have a path to the public network via your proxy host. 