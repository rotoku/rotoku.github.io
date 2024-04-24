---
title: "CKA, CKAD and CKS"
linkTitle: "CKA, CKAD and CKS"
date: 2024-02-14
weight: 1
---

# CKA. CKAD and CKS

## Pré-requisitos de ambiente
- instalação do docker
```bash
curl -fsSL https://get.docker.com | bash
```
- instalação do kind
```bash
# Kind: https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.13.0/kind-linux-amd64

chmod +x ./kind

mv kind /usr/local/bin

kind create cluster
```
- instalação do kubectl
```bash
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

## Instalando via binários
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```
- Alias e Autocomplete
```bash
# Link: https://kubernetes.io/docs/reference/kubectl/cheatsheet/

## autocomplete:
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
## Alias:
alias k=kubectl
complete -F __start_kubectl k

## vim
cat <<EOF > ~/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
EOF


export d="--dry-run=client -o yaml"
```

## Pod
```
kubectl replace --force -f pod.yaml
kubectl run sleep --image busybox --dry-run=client -o yaml -- sleep 1000 > sleep.yaml
kubectl delete pod sleep --force --grace-period 0
```
> O parâmetro --grace-period em Kubernetes é usado para especificar o período de tempo durante o qual o sistema aguardará antes de forçar a exclusão de um recurso, como um pod. O valor é especificado em segundos. Quando você define --grace-period 0, está instruindo o Kubernetes a forçar a exclusão do recurso imediatamente. Isso é útil quando você precisa remover um recurso rapidamente, mas deve ser usado com cuidado, pois pode resultar em um encerramento abrupto do processo, o que pode levar a um estado inconsistente ou a perda de dados.

## ReplicaSet
## Deployment
## StatefulSet
## Service
## Namespace