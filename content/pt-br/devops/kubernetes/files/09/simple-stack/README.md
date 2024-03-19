```
cd /media/rkumabe/DATA/git/rotoku.github.io/content/pt-br/devops/kubernetes/files/09/simple-stack
kubectl apply -f mysql-secrets.yaml
kubectl get secrets mysql-secrets -o yaml
```