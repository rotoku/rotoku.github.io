# DAY 11

## Descomplicando o Kube-Prometheus no EKS

[kube-prometheus.dev](https://prometheus-operator.dev/)

O que é o kube-prometheus?

O kube-prometheus é um conjunto de manifestos do Kubernetes que nos permite ter o Prometheus Operator, Grafana, AlertManager, Node Exporter, Kube-State-Metrics, Prometheus-Adapter instalados e configurados de forma tranquila e com alta disponibilidade. Além disso, ele nos permite ter uma visão completa do nosso cluster de Kubernetes. Ele nos permite monitorar todos os componentes do nosso cluster de Kubernetes, como por exemplo: kube-scheduler, kube-controller-manager, kubelet, kube-proxy, etc.

Se tudo estiver funcionando corretamente, você deverá ver uma lista com os nós do seu cluster EKS. 😄

Antes de seguirmos em frente, vamos conhecer algums comandos do eksctl, para que possamos gerenciar o nosso cluster EKS. Para listar os clusters EKS que temos em nossa conta, basta executar o seguinte comando:

eksctl get cluster -A
O parametro -A é para listar os clusters EKS de todas as regiões. Para listar os clusters EKS de uma região específica, basta executar o seguinte comando:

eksctl get cluster -r us-east-1
Para aumentar o número de nós do nosso cluster EKS, basta executar o seguinte comando:

eksctl scale nodegroup --cluster=eks-cluster --nodes=3 --nodes-min=1 --nodes-max=3 --name=eks-cluster-nodegroup -r us-east-1
Para diminuir o número de nós do nosso cluster EKS, basta executar o seguinte comando:

eksctl scale nodegroup --cluster=eks-cluster --nodes=1 --nodes-min=1 --nodes-max=3 --name=eks-cluster-nodegroup -r us-east-1
Para deletar o nosso cluster EKS, basta executar o seguinte comando:

eksctl delete cluster --name=eks-cluster -r us-east-1
Mas não delete o nosso cluster EKS, vamos utilizar ele para os próximos passos! hahahah

```
git clone https://github.com/prometheus-operator/kube-prometheus
cd kube-prometheus
kubectl create -f manifests/setup
kubectl create -f manifests
kubectl get pods -A
kubectl port-forward -n monitoring svc/grafana 3000:3000 --address=0.0.0.0

kubectl get servicemonitors -n monitoring
```
