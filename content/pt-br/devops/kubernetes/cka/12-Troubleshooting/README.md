# Troubleshooting

## Applications
- check log
- check number restarts
- check connections

## Control Plane
- k get nodes
- k get pods
- k get pods -n kube-system
- service kubelet
- service containerd
- sudo journalctl -u containerd

## Worker Nodes
- k get nodes
- k describe nodes
    - Unknow lost connection with control plane
- service kubelet
- sudo journalctl -u kubelet
- check certs