# Show everything in a namespace

`kubectl get all` doesn't cut it. 

```
kubectl api-resources --verbs=list --namespaced -o name | xargs -n 1 kubectl get --show-kind --ignore-not-found -n <namespace>
```