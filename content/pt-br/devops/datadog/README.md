---
title: "DataDog"
linkTitle: "DataDog"
date: 2025-11-30
weight: 15
---

---------------
---------------
---------------

# DataDog

```
helm repo add datadog https://helm.datadoghq.com
helm install datadog-operator datadog/datadog-operator
kubectl create secret generic datadog-secret --from-literal api-key=<DATADOG_API_KEY>
```

## Create datadog-agent.yaml

```
apiVersion: datadoghq.com/v2alpha1
kind: DatadogAgent
metadata:
  name: datadog
spec:
  global:
    clusterName: kind-kumabes-cluster
    site: datadoghq.com
    credentials:
      apiSecret:
        secretName: datadog-secret
        keyName: api-key
```

```
kubectl apply -f datadog-agent.yaml
```

## Uninstall

```
kubectl delete datadogagent datadog
helm delete datadog-operator
```
