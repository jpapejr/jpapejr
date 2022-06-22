# Accessing a service using `kube proxy`

If you find yourself wanting to do something like a kubectl port-forward but to a Service definition instead of individual pods (i.e. you have several pods for the application and want to see how accessing the app via the Service or Ingress will distribute traffic), you can use the kubectl proxy command to get this done. Follow the steps below:

1. Configure your command line to connect to the chosen Kubernetes cluster (e.g. `ibmcloud ks cluster-config mycluster`)
2. Run `kubectl proxy`
3. Use the following URL format to access your Service: http://localhost:8001/api/v1/proxy/namespaces/NAMESPACE/services/SERVICE_NAME:SERVICE_PORT/

As mentioned above, you use the kubectl cluster-info command to retrieve the service’s proxy URL. To create proxy URLs that include service endpoints, suffixes, and parameters, you simply append to the service’s proxy URL: 

http://kubernetes_master_address/api/v1/namespaces/namespace_name/services/[https:]service_name[:port_name]/proxy

If you haven’t specified a name for your port, you don’t have to specify port_name in the URL.