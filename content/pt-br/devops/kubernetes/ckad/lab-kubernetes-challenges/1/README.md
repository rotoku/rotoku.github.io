# Kubernetes Certified Application Developer (CKAD) with Tests

## Kubernetes Challenges

- Create a pvc
- Create a pod

### 1.

Build user information for martin in the default kubeconfig file: User = martin , client-key = /root/martin.key and client-certificate = /root/martin.crt (Ensure don't embed within the kubeconfig file)
Create a new context called 'developer' in the default kubeconfig file with 'user = martin' and 'cluster = kubernetes'

```
k get pv -A
k get ns


kubectl config set-credentials martin \
    --client-certificate ./martin.crt \
    --client-key ./martin.key

kubectl config use-context developer

kubectl get pods -n development
kubectl get services -n development
kubectl get pvc -n development
```

https://gitlab.com/nb-tech-support/devops.git

### 2.

'developer-role', should have all(\*) permissions for services in development namespace
'developer-role', should have all permissions(\*) for persistentvolumeclaims in development namespace
'developer-role', should have all(\*) permissions for pods in development namespace

```

```

### 3.

create rolebinding = developer-rolebinding, role= 'developer-role', namespace = development
rolebinding = developer-rolebinding associated with user = 'martin'

```

```

### 4.

```

```

### 5.

Service 'jekyll' uses targetPort: '4000', namespace: 'development'
Service 'jekyll' uses Port: '8080', namespace: 'development'
Service 'jekyll' uses NodePort: '30097', namespace: 'development'

```

```

### 6.

pod: 'jekyll' has an initContainer, name: 'copy-jekyll-site', image: 'kodekloud/jekyll'
initContainer: 'copy-jekyll-site', command: [ "jekyll", "new", "/site" ] (command to run: jekyll new /site)
pod: 'jekyll', initContainer: 'copy-jekyll-site', mountPath = '/site'
pod: 'jekyll', initContainer: 'copy-jekyll-site', volume name = 'site'
pod: 'jekyll', container: 'jekyll', volume name = 'site'
pod: 'jekyll', container: 'jekyll', mountPath = '/site'
pod: 'jekyll', container: 'jekyll', image = 'kodekloud/jekyll-serve'
pod: 'jekyll', uses volume called 'site' with pvc = 'jekyll-site'
pod: 'jekyll' uses label 'run=jekyll'

```

```

### 7.

Storage Request: 1Gi
Access modes: ReadWriteMany
pvc name = jekyll-site, namespace = development
'jekyll-site' PVC should be bound to the PersistentVolume called 'jekyll-site'.

```

```
