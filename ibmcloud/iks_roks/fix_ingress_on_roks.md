If your new ROKS cluster doesn't get a cluster sub-domain created and associated with a VPC ALB
properly, this process may help you. 

### Step 1
Create a file with this content:

```
apiVersion: v1
involvedObject:
  apiVersion: v1
  kind: Service
  name: router-default
  namespace: openshift-ingress
  uid: <FILL THIS IN>
kind: Event
lastTimestamp: "2022-01-20T14:30:40Z"
message: Ensuring load balancer
metadata:
  name: router-default
  namespace: openshift-ingress
reason: CloudVPCLoadBalancerNormalEvent
source:
  component: service-controller
type: Normal
```

In the above example, where it says `<FILL THIS IN>` use the UID value from the `router-default` service spec (obtained with
`oc get svc router-default -n openshift-ingress`). 

### Step 2

Apply the yaml with `oc apply -f /path/to/file.yaml`. You should be able to see progress with the `ibmcloud ks nlb-dls ls` and
`ibmcloud ks ingress status` commands. 

You can force a bind of the sub-domain (after created) with the existing healthy VPC ALB for your cluster router by using this:

`ibmcloud ks nlb-dns replace --cluster <ID> --nlb-subdomain <SUBDOMAIN> --lb-host <VPC ALB HOSTNAME>`
