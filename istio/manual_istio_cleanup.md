# Manual Istio cleanup actions

Sometimes Istio doesn't get cleaned up well (the uninstall process is flaky sometimes). These steps were developed for microk8s but could be easily adapted for other environments. 

```
kubectl delete $(kubectl get crd -o name | grep istio); \
kubectl delete $(kubectl get clusterrole -o name | grep istio); \
kubectl delete $(kubectl get clusterrolebinding -o name | grep istio); \
kubectl delete $(kubectl get validatingwebhookconfiguration -o name | grep istio)
```