IBM Cloud IKS and ROKS clusters can leverage NFS-based PVCs out of the box with no additional CSI driver setup. 
This works for VPC-based and classic-based clusters. 

### Step 1
Provision your cluster or skip to step 2 if you already have a cluster up

### Step 2
Create a VPC File Share or Classic File Volume. Note the NFS server and path. 
> Don't forget to authorize your cluster hosts/subnet to access the NFS share!

### Step 3
Create a PV like so:

``` yaml

kind: PersistentVolume
apiVersion: v1
metadata:
  name: myvol
spec:
  capacity:
    storage: 50Gi
  nfs:
    server: <NFS host, e.g. fsf-wdc0451a-fz.adn.networklayer.com>
    path: <NFS volume path, e.g. /nxg_s_voll_mz0757_3bcce10f_dbb9_4241_b3bb_d77785e68376>
  accessModes:
    - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  volumeMode: Filesystem
  storageClassName: ""

```

**Ensure that the `spec.capacity.storage` value matches the actual NFS volume capacity** 

**Ensure that the spec.storageClassName is ""**

### Step 4
Create a PVC that consume the PV

``` yaml

kind: PersistentVolumeClaim
apiVersion: v1
metadata:
  name: my-pv
  namespace: my-namespace
spec:
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 50Gi
  volumeName: myvol
  storageClassName: ''
  volumeMode: Filesystem
```

**Ensure that `spec.volumeName` matches the name of the PV created**

**Ensure that the spec.storageClassName is ''**

At this point, your PVC should show a status of `Bound` in a few seconds. If not, double-check the above YAML definitions
and confirm you gave proper authorization to the NFS volume so your workers can access it. 
