# Troubleshooting kubelet errors on IKS

When you see failures referring to the inability to connect to a worker machine on port 10250 when trying to execute `kubectl exec` or `kubectl logs` commands, check the following:

* Run `(oc|kubectl) logs -n kube-system -l app=vpn --tail 10` -- If this fails with an error involving `WORKERIP:10250`, the vpn tunnel is not working.  

To Further test the VPN do the following:

* Try deleting the current vpn pod
*2.* Run a `ibmcloud ks cluster master refresh` and wait until the Master Status shows something like Ready (5 minutes ago)
 
> Folks tend to assume if the command finished the refresh has also finished, but that's not the case.

* If the vpn pod stayed on the same worker, cordon that worker and delete the vpn pod. If this works, reload the worker.

*  Get list of all calico-node pods in the calico-system namespace and run `(oc|kubectl) exec -n calico-system <VPN_POD_NAME> -- date`  
> If that fails on some pods with an error involving WORKERIP:10250, worker to worker communication is broken and VRF or VLAN spanning are the first things to check.