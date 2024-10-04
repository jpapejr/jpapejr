## Easy AI model download and prep for RHOS AI Model Serving

Using RHOS AI, you can set up model serving from the UI and it will configure the InferenceServer and ServingRuntime
CRs in a way that will look to an s3 bucket to pull the model from every time the model is spun up in Knative Serving. 

If your model is a smaller 7 billion parameter model, you may only wait 5-10 minutes for the initContainer to pull
the model files from s3 and copy them into ephemeral storage in the pod. But when that serving pod is restarted you
have to wait for this to occur all over again. 

There's a better way outlined in [this article](https://medium.com/@fassha08/say-serve-to-llm-on-openshift-ai-openshifts-multi-gpu-marvel-with-kserve-2ab2ed393c63). 

By leveraging the KServe Storage Initializer container and a PVC, we can easily grab the model from s3 one time and then
mount the model into the serving runtime as a PVC to get started much faster!

Example: 

### Step 1 - create a PVC
``` yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  annotations:
    kubernetes.io/reclaimPolicy: Delete
  name: granite-7b-instruct-claim
  namespace: rhosai-smoketest
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 100Gi
  storageClassName: ibmc-vpc-block-10iops-tier
```

> Make sure it's large enough to handle all of the model files!!


### Step 2 - run the pod to transfer the model files

> Note this assumes you have already gotten the files over to an s3 bucket to begin with. I have a [helper script]() that 
> can help out. 


``` yaml
apiVersion: v1
kind: Pod
metadata:
  name: download-granite-7b-instruct
  namespace: rhosai-smoketest
  labels:
    name: download-granite-7b-instruct
spec:
  volumes:
    - name: model-volume
      persistentVolumeClaim:
        claimName: granite-7b-instruct-claim
  restartPolicy: Never
  initContainers:
    - name: fix-volume-permissions
      image: quay.io/quay/busybox@sha256:92f3298bf80a1ba949140d77987f5de081f010337880cd771f7e7fc928f8c74d 
      command: ["sh"]
      args: ["-c", "mkdir -p /mnt/models/granite-7b-instruct && chmod -R 777 /mnt/models"]
      volumeMounts:
        - mountPath: "/mnt/models/"
          name: model-volume
  containers:
    - resources:
        requests:
          memory: 1Gi
        limits:
          memory: 2Gi
      name: download-model
      imagePullPolicy: IfNotPresent
      image: quay.io/modh/kserve-storage-initializer@sha256:330af2d517b17dbf0cab31beba13cdbe7d6f4b9457114dea8f8485a011e3b138
      args:
        - 's3://$(BUCKET_NAME)/granite-7b-instruct/'
        - /mnt/models/granite-7b-instruct
      env:
        - name: AWS_ACCESS_KEY_ID
          value: "<< your value here >>"
        - name: AWS_SECRET_ACCESS_KEY
          value: "<< your value here >>"
        - name: BUCKET_NAME
          value: "<< your value here >>"
        - name: S3_USE_HTTPS
          value: "1"
        - name: AWS_ENDPOINT_URL
          value: "<< your value here >>"
        - name: awsAnonymousCredential
          value: 'false'
        - name: AWS_DEFAULT_REGION
          value: "<< your value here >>"
      volumeMounts:
        - mountPath: "/mnt/models/"
          name: model-volume
```


When these YAMLs are applied in an OpenShift cluster, a new pod will be started which will transfer the model material
from the s3 bucket to the faster PVC storage. 

You can create a model serving instance from the RHOS AI UI, but when asked about the data connection, give it dummy data
so it will fail. Once it's created, go to the API Explorer in the left navigation of the OCP console and search for InferenceService. Find the one named like the Model Serving instance you just created and look at the YAML. You'll see a
reference to the storage bucket and path you put in the form. Replace the entire `storage` block with a PVC URI like 
`storageUri: pvc://granite-7b-instruct-claim/granite-7b-instruct` (Format is `pvc://claim-name/folder`) then save the InferenceService changes. Wait for the new revision of the model serving pod to be rolled out via KNative/KServe. Your
new inference pod should now be loading the model from the PVC instead of the s3 bucket.

``` yaml
apiVersion: serving.kserve.io/v1beta1
kind: InferenceService
metadata:
  annotations:
    openshift.io/display-name: granite-7b-instruct
    security.opendatahub.io/enable-auth: 'true'
    serving.knative.openshift.io/enablePassthrough: 'true'
    sidecar.istio.io/inject: 'true'
    sidecar.istio.io/rewriteAppHTTPProbers: 'true'
  name: granite-7b-instruct
  namespace: rhosai-smoketest
  labels:
    opendatahub.io/dashboard: 'true'
spec:
  predictor:
    maxReplicas: 1
    minReplicas: 1
    model:
      modelFormat:
        name: vLLM
      name: ''
      resources:
        limits:
          cpu: '8'
          memory: 10Gi
          nvidia.com/gpu: '1'
        requests:
          cpu: '4'
          memory: 8Gi
          nvidia.com/gpu: '1'
      runtime: granite-7b-instruct
      storage:
        key: aws-connection-cos-model-bucket
        path: dummy-path
    tolerations:
      - effect: NoSchedule
        key: nvidia.com/gpu
        operator: Exists
```
