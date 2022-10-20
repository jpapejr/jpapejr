Running debug pods on nodes with taints

If you must run debug pods against nodes that have taints on them that would pprevent the debug nodes from being scheduled on them (I.e. dedicated=edge) you must create the debug pods in a specific namespace and patch the namespace with default tolerations.

```
$ oc new-project dummy
$ oc patch namespace dummy --type=merge -p '{"metadata": {"annotations": { "scheduler.alpha.kubernetes.io/defaultTolerations": "[{\"operator\": \"Exists\"}]"}}}'
$ oc debug node/worker-0.example.redhat.com --to-namespace dummy
```

> Reference: https://access.redhat.com/solutions/4976641
