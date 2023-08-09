# OOM_kill reports

When a container/pod exceeds the configured resource limits defined on it, the kernel may perform an oom_kill operation on it, terminating
the workload and allowing it to restart. The details of the state of the workload at the time of the kill are recorded in the system logs 
usually under the `kernel` component. Details on how to interpret this information can be found at the below reference link

[How to interpret an OOMKiller message](https://access.redhat.com/solutions/5788651)
