# [ArgoCD](https://github.com/badtuxx/DescomplicandoArgoCD)

- GitOps: ter um repositório de manifestos e confiar que tudo que vai estar nele vai refletir no cluster kubernetes
- Continuous Deployment
- Custom Resources Definition

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

argocd version

kubectl get svc -n argocd
kubectl port-forward svc/argocd-server -n argocd 8080:443
kubectl get secret argocd-initial-admin-secret -n argocd -o jsonpath="{.data.password}" | base64 -d
argocd login localhost:8080

argocd cluster list
kubectl config current-context
argocd cluster add kind-kind-cluster


kubectl port-forward svc/argocd-server -n argocd 8080:443
argocd login localhost:8080
argocd cluster add kind-kind-cluster

## quando esta utilizando o kind
kubectl get -n default endpoints
172.19.0.3:6443

argocd cluster list
SERVER                          NAME               VERSION  STATUS   MESSAGE                                                  PROJECT
https://172.19.0.3:6443         kind-kind-cluster           Unknown  Cluster has no applications and is not being monitored.
https://kubernetes.default.svc  in-cluster                  Unknown  Cluster has no applications and is not being monitored.


argocd app create nginx-app --repo https://github.com/rotoku/k8s-deploy-nginx-example.git --path . --dest-server https://172.19.0.3:6443 --dest-namespace default

argocd app list

argocd app get nginx-app

argocd app sync nginx-app

argocd app delete nginx-app
```
