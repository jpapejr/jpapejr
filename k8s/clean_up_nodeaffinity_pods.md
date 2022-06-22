Sometimes, when dealing with a cluster that has a lot of node anti-affinity rules, 
rebooting a worker will cause a large number of pods to be in a `NodeAffinity` state
While this doesn't cause a problem, it can be confusing to see them hanging
around in the pod listings.. 

This simple one-liner will dump a list of `kubectl delete pod xxxx` commands to the terminal
for you to copy/paste into the command line to delete these dangling pods. 

``` shell
kubectl get pods -A | grep NodeAffinity | awk '/.*/ {print "kubectl delete pod -n "$1,$2}' 
```