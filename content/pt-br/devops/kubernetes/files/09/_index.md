# DAY 09

## Ingress

O Ingress é um recurso do Kubernetes que gerencia o acesso externo aos serviços dentro de um cluster. Ele funciona como uma camada de roteamento HTTP/HTTPS, permitindo a definição de regras para direcionar o tráfego externo para diferentes serviços back-end. O Ingress é implementado através de um controlador de Ingress, que pode ser alimentado por várias soluções, como NGINX, Traefik ou Istio, para citar alguns.
Tecnicamente, o Ingress atua como uma abstração de regras de roteamento de alto nível que são interpretadas e aplicadas pelo controlador de Ingress. Ele permite recursos avançados como balanceamento de carga, SSL/TLS, redirecionamento, reescrita de URL, entre outros.

### Principais Componentes e Funcionalidades:

- Controlador de Ingress: É a implementação real que satisfaz um recurso Ingress. Ele pode ser implementado através de várias soluções de proxy reverso, como NGINX ou HAProxy.
- Regras de Roteamento: Definidas em um objeto YAML, essas regras determinam como as requisições externas devem ser encaminhadas aos serviços internos.
- Backend Padrão: Um serviço de fallback para onde as requisições são encaminhadas se nenhuma regra de roteamento for correspondida.
- Balanceamento de Carga: Distribuição automática de tráfego entre múltiplos pods de um serviço.
- Terminação SSL/TLS: O Ingress permite a configuração de certificados SSL/TLS para a terminação de criptografia no ponto de entrada do cluster.
- Anexos de Recurso: Possibilidade de anexar recursos adicionais como ConfigMaps ou Secrets, que podem ser utilizados para configurar comportamentos adicionais como autenticação básica, listas de controle de acesso etc.

### Tipos de ingress:

    - [ingress nginx controller](https://kubernetes.github.io/ingress-nginx/)
    - gce ingress
    - aws ingress
    - traefik
    - haproxy
    - kong
    - istio

### Habilitando o Ingress no Minikube

Para habilitar o Ingress no Minikube, basta executar o comando:

```bash
minikube addons enable ingress
kubectl create deployment demo --image=httpd --port=80
kubectl expose deployment demo
kubectl create ingress demo-localhost --class=nginx --rule="demo.localdev.me/*=demo:80"
kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 8080:80
curl --resolve demo.localdev.me:8080:127.0.0.1 http://demo.localdev.me:8080
```

Para habilitar o Ingress no Kind, basta criar um arquivo de configuração do Kind com o seguinte conteúdo:

```yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
    kubeadmConfigPatches:
      - |
        kind: InitConfiguration
        nodeRegistration:
          kubeletExtraArgs:
            node-labels: "ingress-ready=true"
    extraPortMappings:
      - containerPort: 80
        hostPort: 80
        protocol: TCP
      - containerPort: 443
        hostPort: 443
        protocol: TCP
  - role: worker
```

```
kind create cluster --config /media/rkumabe/DATA/git/rotoku/rotoku.github.io/content/pt-br/devops/kubernetes/files/09/kind-cluster.yaml --name kumabes-k8s-cluster
kind get clusters
kind delete clusters $(kind get clusters)
```

### Instalando um Ingress Controller usando o Kind

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/static/provider/kind/deploy.yaml

kubectl wait --namespace ingress-nginx \
  --for=condition=ready pod \
  --selector=app.kubernetes.io/component=controller \
  --timeout=90s

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: example-ingress
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  rules:
  - http:
      paths:
      - pathType: Prefix
        path: /foo(/|$)(.*)
        backend:
          service:
            name: foo-service
            port:
              number: 8080
      - pathType: Prefix
        path: /bar(/|$)(.*)
        backend:
          service:
            name: bar-service
            port:
              number: 8080

```

```
kubectl create ingress contatos-app \
  --class=nginx \
  --rule="contatos-app.localhost/*=contatos-app:3000"

kubectl port-forward --namespace=ingress-nginx service/ingress-nginx-controller 3000:80
```

kubectl get ingress
kubectl get ingress contatos-app-ingress -o jsonpath='{.status.loadBalancer.ingress[0].hostname}'
kubectl get ingress contatos-app-ingress -o jsonpath='{.status.loadBalancer.ingress[0].ip}'

$ k run nginx --image nginx --port 80

$ k get pods
NAME READY STATUS RESTARTS AGE
giropops-senhas-684bc8c6d-h8wnj 1/1 Running 0 7m8s
giropops-senhas-684bc8c6d-jfv4k 1/1 Running 0 7m8s
nginx 1/1 Running 0 13s
redis-deployment-76c5cdb57b-k9wvf 1/1 Running 0 46s

k expose pod nginx

## Ingress controller no aws eks

### Install eksctl

```
# for ARM systems, set ARCH to: `arm64`, `armv6` or `armv7`
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$PLATFORM.tar.gz"

# (Optional) Verify checksum
curl -sL "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_checksums.txt" | grep $PLATFORM | sha256sum --check

tar -xzf eksctl_$PLATFORM.tar.gz -C /tmp && rm eksctl_$PLATFORM.tar.gz

sudo mv /tmp/eksctl /usr/local/bin
```

### Configure

```
eksctl create cluster \
  --name=eks-cluster-1-27 \
  --version=1.27 \
  --region=us-east-1 \
  --nodegroup-name=eks-cluster-1-27-nodegroup \
  --node-type=t3.medium \
  --nodes=2 \
  --nodes-min=1 \
  --nodes-max=3 \
  --managed


eksctl delete cluster \
  --name=eks-cluster-1-27 \
  --region=us-east-1
```

```
eksctl create cluster \
  --name=eks-cluster-1-28 \
  --version=1.28 \
  --region=us-east-1 \
  --nodegroup-name=eks-cluster-1-28-nodegroup \
  --node-type=t3.medium \
  --nodes=2 \
  --nodes-min=1 \
  --nodes-max=3 \
  --managed


eksctl delete cluster \
  --name=eks-cluster-1-28 \
  --region=us-east-1
```

### Trabalhando com multi-context (cluster local, cluster remoto, cluster A e B)

```
k config current-context

k config get-contexts

k config use-context rodrigo.kumabe@eks-cluster-1-27.us-east-1.eksctl.io
```

### [AWS](https://kubernetes.github.io/ingress-nginx/deploy/#aws)

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.10.0/deploy/static/provider/aws/deploy.yaml

kubectl get ns

k get pods -n ingress-nginx

k get svc -n ingress-nginx
```

```
$ kaf app-deployment.yaml
deployment.apps/giropops-senhas created
$ kaf app-service.yaml
service/giropops-senhas created
$ kaf redis-deployment.yaml
deployment.apps/redis-deployment created
$ kaf redis-service.yaml
service/redis-service created
$ k get pods
NAME                                READY   STATUS    RESTARTS   AGE
giropops-senhas-684bc8c6d-pzc4c     1/1     Running   0          23s
giropops-senhas-684bc8c6d-vc7z9     1/1     Running   0          23s
redis-deployment-76c5cdb57b-xfm5w   1/1     Running   0          10s

kaf ingress-5.yaml
k get ingress
```

```
Type: cname
Name: giropops-senhas
Value: a88f0c32eb86241e0b07a7fd5598cabd-81135536823911a1.elb.us-east-1.amazonaws.com
TTL: 1/2 hora

giropops-senhas.kumabe.com.br
```
