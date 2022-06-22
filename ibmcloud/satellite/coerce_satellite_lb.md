In IBK Cloud Satellite ROKS clusters, there are no in-built cloud-provider-controller integrations that will sync up load
balancer resources for your k8s services of `type: LoadBalancer`. Thus, some operations like upgrades may balk because the
Ingress Operator is unhealthy because it never can ensure the LB for the Router. To coerce the operator into a good state,
simply edit the IngressController CR and set: 

``` yaml
  endpointPublishingStrategy:
    NodePortService:
```

**Note**: You might need to delete the default IngressController CR and recreate it to affect the change. 

>reference: https://docs.openshift.com/container-platform/4.8/networking/ingress-operator.html#nw-ingress-controller-endpoint-publishing-strategies_configuring-ingress
