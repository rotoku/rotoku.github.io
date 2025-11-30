# GitOps with ArgoCD

By: https://kodekloud.com

1. Introduction

2. GitOps Introduction

3. ArgoCD Basics
- ArgoCD manifests support
    - kustomize
    - helm
    - kson
    - json
    - kubernetes manifests

- Concepts & Terminology
    - Application
    - Target state
    - Sync
    - Refresh

- ArgoCD Features
    - Automated deployments multiple cluster
    - Audit trails
    - SSO
    - Web Hook Integration
    - Rollback
    - Web UI
    - Automated configuration Drift
    - Out-of-box prometheus $$
    - Support for multiple config management
    - PreSync, Synx, PostSync hooks
    - Multiple tenancy
    - CLI and access token for CI Integration
    - Health sattus
    - Manual Sync

- ArgoCD Architecture

- ArgoCD Installation
    - Core (Stand alone)
    - Multi-Tenant
        - Non HA:
            - install.yaml
            - namespace-install.yaml
        - HA
            - ha/install.yaml
            - ha/namespace-install.yaml

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/v2.4.11/manifests/install.yaml
kubectl get secrets argocd-initial-admin-secret -n argocd -o json | jq .data.password -r | base64 -d

kubectl -n argocd port-forward svc/argocd-server 8080:80
kubectl -n argocd port-forward --address 0.0.0.0 svc/argocd-server 8080:80

argocd login localhost:8080 --insecure
argocd cluster list
```

### Argo Project

```
argocd proj list
NAME     DESCRIPTION  DESTINATIONS  SOURCES  CLUSTER-RESOURCE-WHITELIST  NAMESPACE-RESOURCE-BLACKLIST  SIGNATURE-KEYS  ORPHANED-RESOURCES
default               *,*           *        */*                         <none>                        <none>          disabled

k get appproj -n argocd
NAME      AGE
default   3d22h
```

```
argocd app create solar-system-app-2 \
    --repo https://3000-port-rxqrv5zdsjletwha.labs.kodekloud.com/bob/gitops-argocd.git \
    --path ./solar-system \
    --dest-namespace solar-system \
    --dest-server https://kubernetes.default.svc
```

4. ArgoCD Intermediate
### Reconciliation Loop
- ArgoCD Repository Server
    - observe --> Diff --> Act --> observe

```argocd-cm.yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-cm
  namespace: argocd
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
data:
  timeout.reconciliation: 180s
```

### Git Webhook Configuration
```

```

```

```

```

```
### Application Health
- Healthy - 100% Healthy
- Progressing
- Degraded
- Missing
- Suspended
- Unknown

### Application Custom Health
- writting in Lua Script

```argocd-cm.yaml
apiVersion: v1
data:
  resource.customizations.health.ConfigMap: |
    hs = {}
    hs.status = "Healthy"
    hs.message = ""
    if obj.data.TRIANGLE_COLOR == "white" then
      hs.status = "Degraded"
      hs.message = "Use a different COLOR for TRIANGLE!"
    end
    return hs
kind: ConfigMap
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"ConfigMap","metadata":{"annotations":{},"labels":{"app.kubernetes.io/name":"argocd-cm","app.kubernetes.io/part-of":"argocd"},"name":"argocd-cm","namespace":"argocd"}}
  creationTimestamp: "2025-02-19T18:55:36Z"
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cm
  namespace: argocd
  resourceVersion: "670943"
  uid: 3338fe9c-adb8-4c96-8359-e0f2a7f1ea17
```

### Sync Strategies
- Manual Sync
- Automatic Sync
- Auto-pruning: this features describes what happens when files are deleted or removed from git
- Self-Heal: It defines what ArgoCD does when you make kubectl edit changes directly to the cluster

### Declarative Setup


### App of Apps

### Multi-cluster application deployment
```
argocd cluster list

kubectl config get-contexts -o name 

argocd cluster add kubernetes-admin@kubernetes
```

5. ArgoCD Advanced

6. ArgoCD with Jenkins CI Pipeline