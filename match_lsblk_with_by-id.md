# Matching up the /dev/disk/by-id values with the output from lsblk

There are times when you need to identify block storage devices attached to your linux host so you can utilize them in higher-order systems (like the Local Storage Operator in OpenShift so you can prepare the devices for consumption by OpenShift Data Foundation). This quick and easy one-liner will mash together the output of `lsblk` and the directory structure under `/dev/disk/` to provide a concise view that's easily consumable:

```
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT DEVICE-ID(S)
loop1    7:1    0  550G  0 loop 
vda    252:0    0  100G  0 disk                  /dev/disk/by-id/virtio-0757-deefd5fd-a527-4
|-vda1 252:1    0    1M  0 part                  /dev/disk/by-id/virtio-0757-deefd5fd-a527-4-part1
|-vda2 252:2    0  127M  0 part                  /dev/disk/by-id/virtio-0757-deefd5fd-a527-4-part2
|-vda3 252:3    0  384M  0 part /boot            /dev/disk/by-id/virtio-0757-deefd5fd-a527-4-part3
`-vda4 252:4    0 99.5G  0 part /sysroot                 /dev/disk/by-id/virtio-0757-deefd5fd-a527-4-part4
vdb    252:16   0  372K  0 disk                  /dev/disk/by-id/virtio-cloud-init-0757_3a29
vdc    252:32   0   44K  0 disk                  /dev/disk/by-id/virtio-cloud-init-
vdd    252:48   0  500G  0 disk /var/data                /dev/disk/by-id/virtio-0757-6e89062e-0c7a-4
vde    252:64   0  550G  0 disk                  /dev/disk/by-id/virtio-0757-4665346d-9e80-4
```

Compare against the standard `lsblk` output below: 

```
NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
loop1    7:1    0  550G  0 loop 
vda    252:0    0  100G  0 disk 
|-vda1 252:1    0    1M  0 part 
|-vda2 252:2    0  127M  0 part 
|-vda3 252:3    0  384M  0 part /boot
`-vda4 252:4    0 99.5G  0 part /sysroot
vdb    252:16   0  372K  0 disk 
vdc    252:32   0   44K  0 disk 
vdd    252:48   0  500G  0 disk /var/data
vde    252:64   0  550G  0 disk 
```