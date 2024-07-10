# Cheatsheet for deploying OCP on IBM Cloud VPC with IPI

> Pre-req: Get all your goodies (oc client, openshift-installer, etc) from [here](https://mirror.openshift.com/pub/openshift-v4/x86_64/clients/ocp/)

> IBMers: Go [here](https://pages.github.ibm.com/ramons/technical-notebook/redhat/ocp/#ibm-cloud-ipi) and follow this


### Lessons learned

#### Ensure you create your private DNS or CIS instance in the same resource group that you scoped your IAM service ID credentials against.

When you end up doing your manual credential generation for IBM Cloud you specify a resource group to scope the service ID access to. If your private DNS or Internet Services resource instance is not in the same resource group, the Ingress Operator will fail to be able to access the DNS Zone to verify the `default-wildcard` DNSRecord resource and thus the `Ingress` operator will never come up so you can complete the deployment. 

> To Fix: Either ensure that the DNS/CIS resource is in the same resource group OR update the IAM policy for the ingress operator to include another policy for resources in the desired resource group. Once this is done, the Ingress operator should be able to right itself and the deploy will finnish. 

