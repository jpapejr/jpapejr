Sometimes you want to wait for one resource to be created by Kubernetes
prior to moving on to the next step in your automation/script. After creating
your first resource, use the followin command to wait until the 
associated Kubernetes controller has reconciled the resource before 
moving on:

```shell
kubectl wait --for=condition=Reconciled <kind>/<name>
```