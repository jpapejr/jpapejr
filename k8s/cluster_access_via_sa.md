# Accessing a k8s cluster with a service account

This method will allow you to set up a service account and create a context for it using kubectl config commands.

## Create a service account in your cluster (any namespace works)

```
kubectl create sa <username>
```

## Get the cert and token info from the new service account

### Certificate

```
kubectl get secret $(kubectl get sa jtp -o jsonpath='{.secrets[].name}') -o jsonpath='{.data.ca\.crt}' | base64 -D > <path-to-new-ca-file>
```

### Token

```
kubectl get secret $(kubectl get sa jtp -o jsonpath='{.secrets[].name}') -o jsonpath='{.data.token}' | base64 -D
```

## Create a clusterrolebinding to grant the permissions you want to give

```
kubectl create clusterrolebinding <clusterrolebinding name> --clusterrole=<cluster-role> --serviceaccount=<service account namespace:service account name>
```

## Create a new kube context

### cluster

```
kubectl config set-cluster <clustername> --server=<master url from ibmcloud ks cluster-get <clustername>> --certificate-authority=<path to the ca file from step 2>
```

### User/credentials

```
kubectl config set-credentials <username> --token=<token value from step 2b>
```

### Context

```
kubectl config set-context <contextname> --cluster=<clustername> --user=<username>
```

From here you should be able to use normal kubectl commands to switch contexts/namespaces or you can use tools like kubectx and kubens from https://github.com/ahmetb/kubectx.

This method also allows for non-IAM users to have access to your cluster. (I.e. if you use this method, you don’t have to grant any IBM Cloud users any IAM policies against your cluster or the Container service in general because you can create service accounts in-cluster for anyone and distributed the token and cert values to prospective users and they can use that (and standard k8s tooling) to set up their connection to the cluster.) Furthermore, you’ll have the ability to restrict their access on the granularity of your choosing with clusterrolebindings (cluster level) and rolebindings (per namespace).