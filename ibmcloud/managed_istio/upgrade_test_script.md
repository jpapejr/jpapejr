# IBM Cloud managed Istio upgrade test script

This script can be used to [mostly] manage an automated update of managed Istio on IBM Cloud.

```
export CLUSTER=${1:-"jtp-istio-upgrade"}
export PRE_UPGRADE_ISTIO=${2:-"1.4.6"}
export POST_UPGRADE_ISTIO=${3:-"1.5.0"}

echo "Test parameters:"
echo "----------------"
echo Cluster:                    $CLUSTER
echo Istio pre-upgrade version:  $PRE_UPGRADE_ISTIO
echo Istio post-upgrade version: $POST_UPGRADE_ISTIO
echo
echo

read -p "Press enter to continue"

echo "Install Istio $PRE_UPGRADE_ISTIO"
curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=$PRE_UPGRADE_ISTIO sh -
cd istio-$PRE_UPGRADE_ISTIO
echo "Enable Managed Istio in cluster $CLUSTER"
ibmcloud ks cluster addon enable istio -c $CLUSTER
echo "Obtaining cluster config"
$(ibmcloud ks cluster config -c $CLUSTER --export)
echo "Attempting to label default namespace for Istio sidecar injection"
kubectl label namespace default istio-injection=enabled

echo "Waiting 300s for Istio control plane to materialize in cluster"
sleep 300s

kubectl get pods -n istio-system

read -p "Press enter to continue"

echo "Install BookInfo"
kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply -f samples/bookinfo/networking/bookinfo-gateway.yaml

sleep 15s

export INGRESS_HOST=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
export INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="http2")].port}')
export SECURE_INGRESS_PORT=$(kubectl -n istio-system get service istio-ingressgateway -o jsonpath='{.spec.ports[?(@.name=="https")].port}')

echo "Testing Istio ingress path http://$INGRESS_HOST/productpage"
for i in {1..15}; do sleep 1; curl -s -o /dev/null -w "%{http_code}\n"  http://$INGRESS_HOST/productpage;done

read -p "Press enter to continue"

cd ..
echo "Upgrade to Istio $POST_UPGRADE_ISTIO"

curl -sL https://istio.io/downloadIstio | ISTIO_VERSION=$POST_UPGRADE_ISTIO sh -
cd istio-$POST_UPGRADE_ISTIO
echo "Upgrading Managed Istio in cluster $CLUSTER"
ibmcloud ks cluster addon update istio --version $(echo "$POST_UPGRADE_ISTIO" | cut -d'.' -f1-2) -c $CLUSTER #skipping variablized Istio version here because command is specific

echo "Testing Istio ingress path during upgrade operation"
echo http://$INGRESS_HOST/productpage
for i in {1..300}; do sleep 1; curl -s -o /dev/null -w "%{http_code}\n"  http://$INGRESS_HOST/productpage;done

read -p "Press enter to continue"
kubectl get pods -n istio-system

# CLEANUP
read -p "Clean up?"
ibmcloud ks cluster addon disable istio -c $CLUSTER -f
./samples/bookinfo/platform/kube/cleanup.sh

cd ..
rm -rf istio-$PRE_UPGRADE_ISTIO/
rm -rf istio-$POST_UPGRADE_ISTIO/
```