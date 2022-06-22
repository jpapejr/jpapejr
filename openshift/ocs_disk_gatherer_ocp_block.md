> Source: https://access.redhat.com/solutions/4928841

`oc apply -f https://raw.githubusercontent.com/dmoessne/ocs-disk-gather/master/ocs-disk-gatherer-own-project.yaml`

then `kubectl logs --selector name=ocs-disk-gatherer --tail=-1 --since=10m --namespace default`

The logs will show all the storage devices across the cluster workers:

```
# NODE:compute-0
          # nvme0n1 : 1.5T
        - /dev/disk/by-id/lvm-pv-uuid-c3lSad-cmJh-1Oc9-afGi-dorm-Sz8P-ReUc9K
          # sda : 60G
        - /dev/disk/by-id/scsi-36000c29477c361e09aa3593630a138f5
          # sdb : 10G
        - /dev/disk/by-id/scsi-36000c2944997a920188c40e9072283e0
 -------------------------------------------
          # NODE:compute-1
          # nvme0n1 : 1.5T
        - /dev/disk/by-id/nvme-MO001600KWJSN_PHLE821600NR1P6CGN
          # sda : 60G
        - /dev/disk/by-id/scsi-36000c29b89117dab754e240d65e14797
          # sdb : 10G
        - /dev/disk/by-id/scsi-36000c29fff4553f181a8baea95416e49
 -------------------------------------------
          # NODE:compute-2
          # nvme0n1 : 1.5T
        - /dev/disk/by-id/nvme-MO001600KWJSN_PHLE821600571P6CGN
          # sda : 60G
        - /dev/disk/by-id/scsi-36000c29bc604bb3f298a3322fb2907a8
          # sdb : 10G
        - /dev/disk/by-id/scsi-36000c29f7b560b3b6a50b9a4f260d118
```

Which allows a cluster operator to create PVs via the local storage operator like so:

```
apiVersion: local.storage.openshift.io/v1
kind: LocalVolume
metadata:
  name: local-block
  namespace: local-storage
spec:
  nodeSelector:
    nodeSelectorTerms:
    - matchExpressions:
        - key: cluster.ocs.openshift.io/openshift-storage
          operator: In
          values:
          - ""
  storageClassDevices:
    - storageClassName: localblock
      volumeMode: Block
      devicePaths:
          # NODE:compute-0
          # nvme0n1 : 1.5T
        - /dev/disk/by-id/lvm-pv-uuid-c3lSad-cmJh-1Oc9-afGi-dorm-Sz8P-ReUc9K
          # NODE:compute-1
          # nvme0n1 : 1.5T
        - /dev/disk/by-id/nvme-MO001600KWJSN_PHLE821600NR1P6CGN
          # NODE:compute-2
          # nvme0n1 : 1.5T
        - /dev/disk/by-id/nvme-MO001600KWJSN_PHLE821600571P6CGN
```