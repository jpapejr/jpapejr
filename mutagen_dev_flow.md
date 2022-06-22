> Reference [Mutagen.io](http://mutagen.io)

**Step 1** - `mutagen login` with your key from mutagen.io

**Step 2** - Create a mutagen project. Example follows:

``` yaml
# Set up the Mutagen service and code volume before creating sessions.
beforeCreate:
  - mutagen tunnel create --name zookeeper > tunnel.tunn
  - kubectl create secret generic zookeeper-tunnel --from-file=tunnel.tunn
  - rm -f tunnel.tunn

# Set up the main services after creating sessions. At this point, sessions will
# have been established and code pushed to the shared volume.
afterCreate:

# Pause services after pausing sessions.
afterPause:

# Resume services before resume sessions.
beforeResume:

# Tear down all services and remove the code volume after terminating sessions.
afterTerminate:
  - mutagen tunnel terminate zookeeper

# Define common utility commands.
commands:

# Forward local traffic .
forward:
  zookeeper-web:
    source: "tcp::3000"
    destination: "tunnel://zookeeper:tcp:localhost:3000"

# Synchronize code.
sync:
  defaults:
    flushOnCreate: true
    ignore:
      vcs: true
  code:
    alpha: "."
    beta: "tunnel://zookeeper/code"
    mode: "two-way-resolved"
    ignore:
      paths:
```

**Step 3** - create a PVC to hold the code

``` yaml

apiVersion: v1
kind: PersistentVolumeClaim
metadata:
 name: project-code
spec:
 accessModes:
 - ReadWriteOnce
 resources:
   requests:
     storage: 10Gi
 storageClassName: <DESIRED_STORAGECLASS>
 ```


**Step 4** - customize and apply this yaml:

``` yaml
kind: Deployment
apiVersion: apps/v1
metadata:  
  name: <NAME>
  namespace: <NAMESPACE>
  labels:
    app: <WORKLOAD_LABEL_SELECTOR>
spec:
  replicas: 1
  selector:
    matchLabels:
      app: <WORKLOAD_LABEL_SELECTOR>
  template:
    metadata:
      labels:
        app: <WORKLOAD_LABEL_SELECTOR>
    spec:
      volumes:
        - name: mutagen
          secret:
            secretName: <SECRET_NAME>
            defaultMode: 420
        - name: code
          persistentVolumeClaim:
            claimName: <PVC_NAME>
      containers:
        - name: mutagen
          command:
            - /usr/bin/mutagen
          imagePullPolicy: Always
          volumeMounts:
            - name: mutagen
              readOnly: true
              mountPath: /mutagen
            - name: code
              mountPath: /code
          image: jpapejr/mutagen:latest
          args:
            - tunnel
            - host
            - /mutagen/stdin
        - name: dev
          command:
            - sleep
          args:
            - infinity
          imagePullPolicy: Always
          volumeMounts:
            - name: code
              mountPath: /code
          image: <DEV_CONTAINER_IMAGE>
```

**Step 5** - Use `mutagen project start` to create all the sync and forward resources. `mutagen project pause/resume` to manage lifecycle after that. `mutagen project terminate` to tear down.

---

**Sync example** - `mutagen sync create --name <NAME> <LOCAL DIR> tunnel://<TUNNEL NAME>/code`

**Forward example** - `mutagen forward create --name <NAME> tcp::<PORT> tunnel://<TUNNEL NAME>:tcp::localhost:<PORT>`