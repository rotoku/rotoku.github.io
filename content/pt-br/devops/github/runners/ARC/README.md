# GitHub Action Runner Controller (ARC)

Actions Runner Controller (ARC) é um operador Kubernetes que orquestra e dimensiona executores auto-hospedados para GitHub Actions.

## Pré-requisitos

- Cluster Kubernetes

```
kubectl cluster-info
```

- Helm

```
helm version
```

- kubectl

```
kubectl version --client
```

## How to identified if I use ARC Community or Enterprise?

- [Enterprise](https://github.com/actions/actions-runner-controller/apis/actions.github.com)
- [Enterprise](https://github.com/actions/actions-runner-controller/controllers/actions.github.com)
- [Enterprise](https://github.com/actions/runner)

  - Release: v2.317.0

- [Community](https://github.com/actions/actions-runner-controller/apis/actions.summerwind.net)
- [Community](https://github.com/actions/actions-runner-controller/controllers/actions.summerwind.net)
- [Community](https://github.com/actions/actions-runner-controller/runner/
  - actions-runner-controller-charts/gha-runner-scale-set:0.9.2
  - gha-runner-scale-set-controller:0.9.2
  - actions-runner-controller-charts/gha-runner-scale-set-controller:0.9.2

## Legacy Stuff

- https://github.com/actions-runner-controller

## Instalando o controlador Actions Runner

```

cd charts
cd gha-runner-scale-set-controller/





k create ns arc-systems
k create ns arc-runners

NAMESPACE="arc-systems"
helm install arc \
    --namespace "${NAMESPACE}" \
    --create-namespace \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller

```

## Authenticating to the GitHub API

Você pode autenticar o Actions Runner Controller (ARC) na API GitHub usando um aplicativo GitHub ou um token de acesso pessoal (clássico).

> Observação: você não pode autenticar usando um aplicativo GitHub para executores em nível empresarial.

## Install Controllers

```
echo "$GITHUB_TOKEN" | docker login ghcr.io -u "$GITHUB_TOKEN" --password-stdin

echo "$GITHUB_TOKEN" | helm registry login ghcr.io -u rotoku --password-stdin

helm install arc \
    --namespace arc-system \
    --create-namespace \
    --set image.tag="0.9.2" \
    -f /media/rkumabe/DATA/workspaces/arc-configuration/controller/values.yaml \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set-controller \
    --version "0.9.2"
```

## Install Runner Scale Set

```
k create arc-runners
kubectl apply -f /media/rkumabe/DATA/Documents/md/2024/gh-app-arc-community-secret.yaml

## First time
helm install kumabes-runner-large \
    --namespace arc-runners \
    -f /media/rkumabe/DATA/workspaces/arc-configuration/runner-scale-set-1/values.yaml \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set \
    --version "0.9.2"

helm install arc-kumabes-runner-small \
    --create-namespace \
    --namespace arc-runners \
    -f /media/rkumabe/DATA/workspaces/arc-configuration/runner-scale-set-2/values.yaml \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set \
    --version "0.9.2"

helm install kumabes-runner-dind-medium \
    --create-namespace \
    --namespace arc-runners \
    -f /media/rkumabe/DATA/workspaces/arc-configuration/runner-scale-set-3/values.yaml \
    oci://ghcr.io/actions/actions-runner-controller-charts/gha-runner-scale-set \
    --version "0.9.2"


helm list -A


helm uninstall kumabes-runner-large -n arc-runners
```

## DIND

```
https://github.com/actions/runner-container-hooks
```
