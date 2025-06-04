

## 📘 Deployment Guide for Argo CD and Tekton Pipelines on MicroShift

### 🧰 Prerequisites
- MicroShift installed and running on RHEL 9
- `kubectl` configured to access the MicroShift cluster
- Internet access for pulling container images

---

### 🚀 Deploying Argo CD

#### Step 1: Create Namespace
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: argocd
```

Apply with:
```bash
kubectl apply -f <filename>.yaml
```

#### Step 2: Install Argo CD Components
```bash
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

#### Step 3: Access Argo CD
- Port-forward the Argo CD API server:
  ```bash
  kubectl port-forward svc/argocd-server -n argocd 8080:443
  ```
- Access via `https://localhost:8080`
- Default login:
  - Username: `admin`
  - Password: Run:
    ```bash
    kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath=\"{.data.password}\" | base64 -d && echo
    ```

---

### 🔧 Deploying Tekton Pipelines

#### Step 1: Create Namespace
```yaml
apiVersion: v1
kind: Namespace
metadata:
  name: tekton-pipelines
```

#### Step 2: Install Tekton Pipelines
```bash
kubectl apply -f https://storage.googleapis.com/tekton-releases/pipeline/latest/release.yaml
```

#### Step 3: Verify Installation
```bash
kubectl get pods -n tekton-pipelines
```

