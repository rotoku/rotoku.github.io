# [DAY 10](https://github.com/badtuxx/DescomplicandoKubernetes/blob/main/pt/day-10/README.md#instalando-e-configurando-o-cert-manager)

## Descomplicando Ingress com TLS, Labels, Annotations e o Cert-manager

- [Let's Encrypt](https://letsencrypt.org/pt-br/) - Certificate Manager
- [Cert-manager](https://cert-manager.io/) - gerenciar certificados
    - issuer: somente para um namespace
    - cluster issuer: para todos os namespaces do cluster do k8s

### [Instalando o Cert-Manager](https://cert-manager.io/docs/installation/kubectl/)
Custom Resource Definition = Expandindo o Cluster K8S
```
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.14.4/cert-manager.yaml

k get pods -n cert-manager

kaf letsencrypt-issuers/staging-issuer.yaml 
issuer.cert-manager.io/letsencrypt-staging created

kaf letsencrypt-issuers/production-issuer.yaml 
clusterissuer.cert-manager.io/letsencrypt-prod created

k get issuers
NAME                  READY   AGE
letsencrypt-staging   True    68s

k get clusterissuers
NAME               READY   AGE
letsencrypt-prod   True    84s


kubectl describe clusterissuers letsencrypt-prod

k get secrets
NAME                  TYPE     DATA   AGE
letsencrypt-staging   Opaque   1      2m19s

k get secrets -n cert-manager
NAME                      TYPE     DATA   AGE
cert-manager-webhook-ca   Opaque   3      13m
letsencrypt-prod          Opaque   1      2m54s

kaf ingress-6.yaml
ingress.networking.k8s.io/giropops-senhas configured

k get certificaterequests.cert-manager.io
NAME                    APPROVED   DENIED   READY   ISSUER             REQUESTOR                                         AGE
giropops-senhas-tls-1   True                True    letsencrypt-prod   system:serviceaccount:cert-manager:cert-manager   56s

k get secrets
NAME                  TYPE                DATA   AGE
giropops-senhas-tls   kubernetes.io/tls   2      77s
letsencrypt-staging   Opaque              1      14m

k describe certificaterequests.cert-manager.io
```

### O que são annotations e as labels
- annotations: é uma forma de passar informações/configurações para que as aplicações/Custom Resource Definition consigam consumir (aplicação/sre)
- labels: organização, agrupar, marcador para fazer o match (svc/pods)

### Labels
kubectl get pods --selector=app
kubectl get all --selector=app
kubectl label --help
kubectl explain pod

kubectl label pods redis-deployment-76c5cdb57b-599tj nome=rodrigo
kubectl describe pods redis-deployment-76c5cdb57b-599tj
kubectl label pods redis-deployment-76c5cdb57b-599tj nome=kumabe --overwrite
kubectl get pods -L app

### Annotations
kubectl annotate redis-deployment-76c5cdb57b-599tj

kubectl get pods redis-deployment-76c5cdb57b-599tj -o jsonpath='{.metadata.annotations}'


```
sudo apt install apache2-utils
htpasswd -c auth rkumabe
kubectl create secret generic giropops-senhas-users --from-file=auth
kubectl describe secrets giropops-senhas-users
kubectl get secrets giropops-senhas-users -o yaml
```

