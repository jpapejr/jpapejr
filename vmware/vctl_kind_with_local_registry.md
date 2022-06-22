The steps below will result in a local kind cluster using vctl for the CRI with a local registry. 

**Step 1**

vctl kind

**Step 2**

``` shell
vctl run --restart=always -d -p "127.0.0.1:5000:5000" "kind-registry" \
  &&  export reg_name=$(docker describe ${reg_name} | grep "IP address:" | awk '/.*/ {print $3}')
```

**Step 3**

``` shell
cat <<EOF | kind create cluster --config=-
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
containerdConfigPatches:
- |-
  [plugins."io.containerd.grpc.v1.cri".registry.mirrors."localhost:5000"]
    endpoint = ["http://${reg_name}:5000"]
EOF
```

`vctl ps` should show two containers running - `kind-control-plane` and `kind-registry`. The KinD cluster should be setup to 
pull images taged with `localhost:500/xxxx/xxxx:xxx` from `reg_name`:5000/xxxx/xxxx:xxx