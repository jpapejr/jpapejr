Sometimes we need to quickly do some storage tests to determine if performance bottlenecks are IOPs-related, application related, or something else.


1. Create a PVC of the desired storage class


2. Create a test pod with: 
```
apiVersion: v1
kind: Pod
metadata:
  name: ubuntu
  labels:
    app: ubuntu
spec:
  containers:
  - name: ubuntu
    image: ubuntu:18.04
    imagePullPolicy: IfNotPresent
    command: ["/bin/sleep", "3650d"]
    resources: {}
    securityContext:
      privileged: true
      runAsUser: 0
    volumeMounts:
    - name: persistent-storage-mount-fs
      mountPath: "/var/perfps"
  volumes:
  - name: persistent-storage-mount-fs
    persistentVolumeClaim:
      claimName: pvc-perf
  restartPolicy: Always
```

3. Once the pod is running exec into the pod using, `oc exec ubuntu -it -- sh`

4. Once inside the pod install ioping and fio:
```
apt-get update
apt-get install fio
```

5. Then here are some example fio commands that can be used to test different concurrency/block sizes:

```
fio --ioengine=libaio --iodepth=64 --direct=1 --size=2G --time_based --group_reporting --runtime=60 --ramp_time=10 --bs=4k --rw=write --directory=/var/perfps --name=test-4k-64depth-write

fio --ioengine=libaio --iodepth=1 --direct=1 --size=2G --time_based --group_reporting --runtime=60 --ramp_time=10 --bs=4k --rw=write --directory=/var/perfps --name=test-4k-1depth-write

fio --ioengine=libaio --iodepth=64 --direct=1 --size=2G --time_based --group_reporting --runtime=60 --ramp_time=10 --bs=100k --rw=write --directory=/var/perfps --name=test-100k-64depth-write

fio --ioengine=libaio --iodepth=1 --direct=1 --size=2G --time_based --group_reporting --runtime=60 --ramp_time=10 --bs=100k --rw=write --directory=/var/perfps --name=test-100k-1depth-write
```
 
