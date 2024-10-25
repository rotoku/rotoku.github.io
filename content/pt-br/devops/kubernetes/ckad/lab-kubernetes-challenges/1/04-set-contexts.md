```
kubectl config get-contexts

kubectl config set-credentials martin \
    --client-certificate ./martin.crt \
    --client-key ./martin.key

kubectl config set-context developer --user=martin --cluster kubernetes

kubectl config use-context developer

kubectl get pod -n developer
kubectl get pvc -n developer
kubectl get svc -n developer

kubectl config use-context kubernetes-admin@kubernetes
```
