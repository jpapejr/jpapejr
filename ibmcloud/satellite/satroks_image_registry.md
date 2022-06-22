To set up a PVC as the OCP internal registry storage backing, open `config.imageregistry` and add

```
storage:
  pvc:
    claim: image-registry-storage
```

and designate an existing PVC. 