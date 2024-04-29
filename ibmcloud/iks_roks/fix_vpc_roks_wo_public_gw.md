When a ROKS cluster is created but the subnets don't have public gateways attached, some components won't bootstrap/self-configure correctly OOTB.
The following steps will remedy this.


**Fix the following components:

**Developer catalog**

`oc edit configs.samples.operator.openshift.io/cluster`

 change `managementState: Removed to managementState:Managed`

 save & close

 `oc edit OperatorHub` and set `disableAllDefaultSources: true` to `disableAllDefaultSources: false`
 
save & close

**OperatorHub panel**

`oc get pods -n openshift-marketplace`

For each pod in the output, restart the pod: `oc delete pod <pod> -n openshift-marketplace`

**Multus operator**

`oc get pods -n openshift-multus`

For each multus-admission-controller pod in the output, restart the pod: `oc delete pod <pod> -n openshift-multus`

**Samples operator**

Copy the `openshift-config/pull-secret` to the samples operator project: `oc get secret pull-secret -n openshift-config -o yaml | sed ‘s/openshift-config/openshift-cluster-samples-operator/g’ | oc -n openshift-cluster-samples-operator create -f -`

You may need to delete the operator pod
