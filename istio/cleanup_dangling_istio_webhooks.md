# Cleaning up dangling Istio webhooks

Istio uninstall can be problematic and the k8s webhook configurations it creates are not always removed properly. These commands can be used to remove them from the cluster:

```
kubectl delete mutatingwebhookconfigurations.admissionregistration.k8s.io istio-sidecar-injector

kubectl delete validatingwebhookconfigurations.admissionregistration.k8s.io istio-galley
```