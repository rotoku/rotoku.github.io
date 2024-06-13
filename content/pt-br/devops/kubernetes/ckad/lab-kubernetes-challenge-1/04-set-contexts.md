```
kubectl config view

kubectl config --kubeconfig=config-demo set-credentials developer --client-certificate=/root/martin.crt --client-key=/root/martin.key
kubectl config --kubeconfig=config-demo set-credentials experimenter --username=exp --password=some-password

kubectl config get-contexts
kubectl config use-context martin@kubernetes
kubectl config use-context kubernetes-admin@kubernetes


kubectl config set-context developer --user=martin --cluster kubernetes
kubectl config use-context developer
```
