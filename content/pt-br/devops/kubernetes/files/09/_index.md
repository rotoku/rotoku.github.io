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
- role: worker
- role: worker    
```

```
kind create cluster --config /media/rkumabe/DATA/git/rotoku.github.io/content/pt-br/devops/kubernetes/files/09/kind-cluster.yaml --name kind-cluster
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

kubectl port-forward service/giropops-senhas 5000:5000
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
