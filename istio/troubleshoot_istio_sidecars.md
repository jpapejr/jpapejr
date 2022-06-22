# Troubleshooting envoy sidecars

## To troubleshoot

```
kubectl logs <pod> -c istio-proxy
```

Look for warnings/errors in the envoy proxy logs.

## See where the communication is breaking

Make sure the proxy can talk to the workload

```
kubectl exec <b-pod> -c istio-proxy -- curl -v localhost:<port>/dosomecrazystuff
```

Make sure the proxy can talk to other proxy sidecars

```
Non-TLS

kubectl exec <a-pod> -c istio-proxy -- curl -v http://B.default.svc.cluster.local/dosomecrazystuff

TLS

kubectl exec <a-pod> -c istio-proxy -- curl https://B.default.svc.cluster.local/dosomecrazystuff --key /etc/certs/key.pem --cert /etc/certs/cert-chain.pem --cacert /etc/certs/root-cert.pem -k
```