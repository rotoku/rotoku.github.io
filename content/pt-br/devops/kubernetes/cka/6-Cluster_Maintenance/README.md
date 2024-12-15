# Cluster Maintenance

## Operating System Upgrades
5 minutes until kube-api reschedule in another node.
### Secure way manually
```
kubectl drain node01
kubectl drain node01 --ignore-daemonsets
kubectl drain node01 --ignore-daemonsets --force

kubectl uncordon node01  (voltar agendamento)
kubectl cordon node01 (sem agendamento)
```

### Releases
- semantic version
- k8s works with beta, alpha and stable

There different versions, because are another project structure
- etcd
- coredns 
## Cluster Upgrade Process

## Backup and Recovery Methodologies
