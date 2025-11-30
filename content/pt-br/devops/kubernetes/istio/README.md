# Istio


## Install Helm

```bash
sudo apt-get install curl gpg apt-transport-https --yes
curl -fsSL https://packages.buildkite.com/helm-linux/helm-debian/gpgkey | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null
echo "deb [signed-by=/usr/share/keyrings/helm.gpg] https://packages.buildkite.com/helm-linux/helm-debian/any/ any main" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list
sudo apt-get update
sudo apt-get install helm
```

## Create some resources for testing
```bash
k apply -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/bookinfo/platform/kube/bookinfo.yaml
```

## Download Istio CTL
```bash
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.26.5 sh -

sudo install -m 755 /root/istio-1.26.5/bin/istioctl /usr/local/bin/istioctl

istioctl version
```

## Install Istio with profile demo
```bash
istioctl install --set profile=demo -y
```

## Check Istio Installation
```bash
kubectl get pods -n istio-system
```

## Analyze
```bash
istioctl analyze -n default
```

## Inject Istio into namespace
```bash
kubectl label namespace default istio-injection=enabled
```


```bash
kubectl create ns db
```

```bash
kubectl run redis-no-proxy --image=redis --namespace db
```

```bash
kubectl run redis --image=redis --namespace db --dry-run=client -o yaml > pod.yaml
```

```bash
istioctl kube-inject -f pod.yaml | kubectl apply -f -
```


## Install Istio with profile ambient (layer 4, from OSI)
```bash
istioctl install --set profile=ambient -y
```

## Inject Istio into namespace
```bash
kubectl label namespace default istio.io/dataplane-mode=ambient
```

## Check Istio Installation
```bash
kubectl get pods -n istio-system
```

```bash
kubectl run nginx --image=nginx
kubectl get pods nginx

kubectl logs -f -n istio-system -l app=ztunnel --all-containers=true
```

```
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.4.0/standard-install.yaml
```

```
istioctl waypoint apply -n default
```

```
istioctl waypoint delete --all -n default
```

```
sudo install -m 755 /root/istio-1.26.6/bin/istioctl /usr/local/bin/istioctl
```

## Install using helm
```
helm repo add istio https://istio-release.storage.googleapis.com/charts
helm repo update
helm repo list
kubectl get crd

helm install istio-base istio/base \
    -n istio-system \
    --create-namespace \
    --version 1.26.6 \
    --set profile=demo

helm install istiod istio/istiod \
    -n istio-system \
    --version 1.26.6 \
    --set profile=demo \
    --set pilot.resources.requests.memory=128Mi \
    --set pilot.resources.requests.cpu=250m

kubectl create namespace istio-ingress

helm install istio-ingress istio/gateway -n istio-ingress --version 1.26.6 --wait

helm show values istio/istiod > istiod.yaml

helm show values istio/gateway > gateway.yaml

helm upgrade istio-ingress istio/gateway -n istio-ingress -f gateway.yaml
```

## Customizing Istio with IstioOperator

```
istioctl install -f default.yaml

helm show values istio/base > istio_base.yaml

helm install istio-base istio/base -n istio_system -f istio_base.yaml


k apply -f https://raw.githubusercontent.com/istio/istio/release-1.28/samples/bookinfo/platform/kube/bookinfo.yaml
```

## Uninstall Istio
```bash
istioctl uninstall --set profile=default --purge

istioctl uninstall --set profile=demo --purge

helm uninstall istio-ingress -n istio-ingress
```



```bash
istioctl validate -f demo.yaml 
istioctl install -f demo.yaml -y
istioctl upgrade -f demo.yaml

istioctl uninstall -f demo.yaml -y
```

## Canary Release Istio Upgrade
```bash
curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.26.2 sh -
sudo install -m 755 /root/istio-1.26.2/bin/istioctl /usr/local/bin/istioctl
istioctl version
istioctl install --set profile=demo -y

istioctl proxy-status

curl -L https://istio.io/downloadIstio | ISTIO_VERSION=1.26.5 sh -
sudo install -m 755 /root/istio-1.26.5/bin/istioctl /usr/local/bin/istioctl
istioctl version
istioctl install --set profile=demo --revision 1-26-5 -y
istioctl tag set latest --revision 1-26-5

kubectl edit namespace default

labels:
    de: istio-injection: enabled
    para: istio.io/rev: latest

istioctl tag list -n istio-system


kubectl delete -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/bookinfo/platform/kube/bookinfo.yaml
kubectl apply  -f https://raw.githubusercontent.com/istio/istio/release-1.11/samples/bookinfo/platform/kube/bookinfo.yaml

kubectl get pods -n istio-system --show-labels | grep 'istio.io/rev=default'

istioctl uninstall --revision default -y

kubectl get pods -n istio-system --show-labels | grep 'istio.io/rev=default'
```