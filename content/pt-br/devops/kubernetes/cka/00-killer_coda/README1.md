# Killer Coda

## Scenario 01
```

```

## Scenario 02 - vim-setup
```~/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
```

## Scenario 03 - apiserver-crash
```
Log locations to check:
/var/log/pods
/var/log/containers
crictl ps + crictl logs
docker ps + docker logs (in case when Docker is used)
kubelet logs: /var/log/syslog or journalctl
```

## Scenario 04 - apiserver-misconfigured
```

```

## Scenario 05 - 
```

```

## Scenario 06 - 
```

```

## Scenario 07 - 
```

```

## Scenario 08 - 
```

```

## Scenario 01
```

```

## Scenario 02
```

```

## Scenario 03
```

```

## Scenario 04
```

```

## Scenario 01
```

```

## Scenario 02
```

```

## Scenario 03
```

```

## Scenario 04
```

```

## Scenario 01
```

```

## Scenario 02
```

```

## Scenario 03
```
kubeadm join 172.30.1.2:6443 --token btvqjd.im1whed8kllfem9t --discovery-token-ca-cert-hash sha256:0d46e9adf05aa51c0c0bd38b751ec56d1bb7c31cdac49e71df1b043f879f2149

```

## Scenario 20
```
--kubernetes-version=1.31.0

kubeadm token create --print-join-command

kubeadm token list
```


```
kubectl drain controlplane --ignore-daemonsets

k get nodes

sudo apt update
sudo apt-cache madison kubeadm

sudo apt-mark unhold kubeadm kubectl kubelet && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.31.4-1.1' kubectl='1.31.4-1.1' kubelet='1.31.4-1.1'  && \
sudo apt-mark hold kubeadm kubectl kubelet 

kubeadm version
kubectl version
kubelet --version

sudo kubeadm upgrade plan
sudo kubeadm upgrade apply v1.31.4

sudo systemctl daemon-reload
sudo systemctl restart kubelet

kubectl uncordon controlplane
```

```
kubectl drain node01 --ignore-daemonsets
ssh node01
k get nodes

sudo apt update
sudo apt-cache madison kubeadm

sudo apt-mark unhold kubeadm kubectl kubelet && \
sudo apt-get update && sudo apt-get install -y kubeadm='1.31.4-1.1' kubectl='1.31.4-1.1' kubelet='1.31.4-1.1'  && \
sudo apt-mark hold kubeadm kubectl kubelet 

kubeadm version
kubectl version
kubelet --version

sudo systemctl daemon-reload
sudo systemctl restart kubelet

kubectl uncordon node01
```