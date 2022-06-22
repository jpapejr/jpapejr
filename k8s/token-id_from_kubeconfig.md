# Get tokenId from KUBECONFIG easily

This script will extract and show you the token-id value from your KUBECONFIG

```
kubectl config view -o json | jq '.users[] | select(.name | contains("<username>"))' | grep id-token | cut -d":" -f2 | tr -d '"' | tr -d ','
```