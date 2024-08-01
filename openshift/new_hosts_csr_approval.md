# Adding hosts with Assisted Installer may appear to hang

When adding hosts to an existing cluster via the Assisted Installer (AI), the new hosts may appear to hang needing client interaction in the hybrid cloud
console (console.redhat.com). This may be due to pending Certificate Signing Requests (CSRs) being made for the Kubelet certs which need to be signed by
the cluster CA to complete integration into the cluster. Refer to [this link](https://access.redhat.com/solutions/6748611) for details on how to fix. 

#### tl;dr

>Seeing this?
>
```
Feb 18 08:07:29 nodename hyperkube[3602]: E0218 08:07:29.963621    3602 transport.go:112] "No valid client certificate is found but the server is not responsive. A restart may be necessary to retrieve new initial credentials." lastCertificateAvailabilityTime="2022-02-16 08:50:28.943096211 +0000 UTC m=+0.345942418" shutdownThreshold="5m0s"
Feb 18 08:07:30 nodename hyperkube[3602]: I0218 08:07:30.026075    3602 csi_plugin.go:1057] Failed to contact API server when waiting for CSINode publishing: csinodes.storage.k8s.io "nodename" is forbidden: User "system:anonymous" cannot get resource "csinodes" in API group "storage.k8s.io" at the cluster scope
Feb 18 08:07:30 nodename hyperkube[3602]: E0218 08:07:30.027093    3602 kubelet.go:2435] "Error getting node" err="node \"nodename\" not found"
```

>Do this:

```
oc get csr | grep -i pending
```

> If you see Pending requests do:

```
for i in `oc get csr --no-headers | grep -i pending |  awk '{ print $1 }'`; do oc adm certificate approve $i; done
```

Monitor for host addition completion.
