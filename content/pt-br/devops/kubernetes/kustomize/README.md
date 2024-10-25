# Kustomize

Why Kustomize?

```base
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-deployment
spec:
  replicas: 1
  selector:
    matchLabels:
      component: nginx
  template:
    metadata:
      labels:
        component: nginx
    spec:
      containers:
      - image: nginx
        name: nginx
```

```overlays/dev
spec:
  replicas: 1
```

```overlays/stg
spec:
  replicas: 2
```

```overlays/prod
spec:
  replicas: 5
```

## Folder Structure

```
k8s/
    base/
        kustomization.yaml
        nginx-deploy.yaml
        service.yaml
        redis-deploy.yaml
    overlays/
        dev/
            kustomization.yaml
            config-map.yaml
        stg/
            kustomization.yaml
            config-map.yaml
        prod/
            kustomization.yaml
            config-map.yaml
```

Kustomize = Base + Overlays --> Final Manifests

## Kustomize vs Helm

- Helm makes use of go templates to allow assigning variables to properties.
- Helm is more then just a tool to customize configurations on a per environments basis. Helm is also a package manager for your App
- Helm provides extra features like conditionals, loops, functions, and hooks.
- Helm templates are not valid YAML as they use go templating syntax
  - Complex templates become hard to read

## Kustomize Basics

```
curl -s "https://raw.githubusercontent.com/kubernetes-sigs/kustomize/master/hack/install_kustomize.sh" | bash
sudo mv kustomize /usr/local/bin/
kustomize version --short
```

## Kustomization.yaml File

```
k8s/
  nginx-deploy.yaml
  nginx-service.yaml
  kustomization.yaml
```

```kustomization.yaml
# kubernetes resources to be managed by kustomize
resources:
  - nginx-deploy.yaml
  - nginx-service.yaml
# Customizations that need to be made
commonLabels:
  company: kumabes-org
```

```
kustomize build k8s/
```

- Kustomize looks for a kustomization file which contains:
  - List of all the Kubernetes manifests kustomize should manage
  - All of the customizations that should be applied
- The kustomize build command combines all the manifests and applies the defined transformations
- The kustomize build command does not apply/deploy the Kubernetes resources to a cluster
  - The output needs to redirected to the kubectl apply command

## Kustomize output

```Apply Kustomize Configs
kustomize build k8s/ | kubectl apply -f -
kubectl apply -k k8s/

kustomize build k8s/ | kubectl delete -f -
kubectl delete -k k8s/
```

## Kustomize ApiVersion & Kind

```
apiVersion: kustomize.config.k8s.io/v1beta1
kind: Kustomization
# kubernetes resources to be managed by
kustomize
resources:
    - nginx-depl.yaml
    - nginx-service.yaml
#Customizations that need to be made
commonLabels:
    company: kumabes-org
```

## Managing Directories
