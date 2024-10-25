# prometheus-community

### Add the Prometheus community repository:
```
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
helm repo list
```

### Create a monitoring namespace and install Kube-Prometheus:
```
kubectl create namespace monitoring
helm install kube-prometheus prometheus-community/kube-prometheus-stack -n monitoring
helm list -n monitoring
kubectl get all -n monitoring
```

Grafana: admin@prom-operator

```
kubectl port-forward -n monitoring svc/kube-prometheus-grafana 3000:80
kubectl port-forward -n monitoring svc/kube-prometheus-kube-prome-alertmanager 9093:9093
kubectl port-forward -n monitoring svc/kube-prometheus-kube-prome-prometheus 9090:9090
```

## If you use cloud k8s manager (aks, eks, gke)
```values.yaml
kubeScheduler:
  enabled: false
kubeControllerManager:
  enabled: false
```


```
helm upgrade -f values.yaml kube-prometheus prometheus-community/kube-prometheus-stack -n monitoring
```

```values.yaml
prometheus:
  prometheusSpec:
    podMonitorSelectorNilUsesHelmValues: false
    serviceMonitorSelectorNilUsesHelmValues: false
```

```
helm upgrade -f values.yaml kube-prometheus prometheus-community/kube-prometheus-stack -n monitoring
```

## Modificando a instalação do Helm
Começarei modificando minha própria instalação do Helm para que possamos configurar opções globais para definir a URL do Slack nela e também fazer mais algumas configurações relacionadas a como vamos gerenciar o CRD AlertManagerConfig, para isso, meu values.yaml que é usado para personalização do Helm ficaria assim

```values.yaml
prometheus:
  prometheusSpec:
    podMonitorSelectorNilUsesHelmValues: false
    serviceMonitorSelectorNilUsesHelmValues: false

alertmanager:
  config:
    global:
      slack_api_url: <SLACK_URL_YOU_HAVE_COPIED_FORM_BEFORE>
  alertmanagerSpec:
    alertmanagerConfigNamespaceSelector:
    alertmanagerConfigSelector:
    alertmanagerConfigMatcherStrategy:
      type: None
```

```
helm upgrade -f values.yaml kube-prometheus prometheus-community/kube-prometheus-stack -n monitoring
```