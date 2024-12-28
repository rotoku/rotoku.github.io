# Introduction
```
alias k="kubectl"
alias kaf="kubectl apply -f"
alias ll="ls -lrth --color"
export do="--dry-run=client -o yaml"

kubectl get pods -o json | jq -c "paths"
kubectl explain pod.spec.containers --recursive
```







## Design and Install a Kubernetes Cluster
## Install "Kubernetes the kubeadm way"
## Troubleshooting
## Other Topics
## Lightning Labs
## Mock Exams