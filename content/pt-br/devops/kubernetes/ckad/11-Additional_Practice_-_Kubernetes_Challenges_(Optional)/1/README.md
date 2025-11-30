# Kubernetes Challenge 1


```
alias ll="ls -lrth --color"
alias k="kubectl"
alias ks="kubectl -n kube-system"
export do="--dry-run=client -o yaml"
```

## martin
```
Build user information for martin in the default kubeconfig file: User = martin , client-key = /root/martin.key and client-certificate = /root/martin.crt (Ensure don't embed within the kubeconfig file)

Create a new context called 'developer' in the default kubeconfig file with 'user = martin' and 'cluster = kubernetes'
```

## PersistentVolume
```jekyll-site.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"PersistentVolume","metadata":{"annotations":{},"name":"jekyll-site"},"spec":{"accessModes":["ReadWriteMany"],"capacity":{"storage":"1Gi"},"local":{"path":"/site"},"nodeAffinity":{"required":{"nodeSelectorTerms":[{"matchExpressions":[{"key":"kubernetes.io/hostname","operator":"In","values":["node01"]}]}]}},"persistentVolumeReclaimPolicy":"Delete","storageClassName":"local-storage","volumeMode":"Filesystem"}}
  creationTimestamp: "2025-01-15T17:15:54Z"
  finalizers:
  - kubernetes.io/pv-protection
  name: jekyll-site
  resourceVersion: "591"
  uid: ec24fa56-7a06-40f9-81a0-5a52edf989cc
spec:
  accessModes:
  - ReadWriteMany
  capacity:
    storage: 1Gi
  local:
    path: /site
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - node01
  persistentVolumeReclaimPolicy: Delete
  storageClassName: local-storage
  volumeMode: Filesystem
status:
  lastPhaseTransitionTime: "2025-01-15T17:15:54Z"
  phase: Available
```

## PersistentVolumeClaim
Storage Request: 1Gi

Access modes: ReadWriteMany

pvc name = jekyll-site, namespace = development

'jekyll-site' PVC should be bound to the PersistentVolume called 'jekyll-site'.

```jekyll-site.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: jekyll-site
  namespace: development
spec:
  storageClassName: local-storage
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 1Gi
```

## Pod
pod: 'jekyll' has an initContainer, name: 'copy-jekyll-site', image: 'gcr.io/kodekloud/customimage/jekyll'

initContainer: 'copy-jekyll-site', command: [ "jekyll", "new", "/site" ] (command to run: jekyll new /site)

pod: 'jekyll', initContainer: 'copy-jekyll-site', mountPath = '/site'

pod: 'jekyll', initContainer: 'copy-jekyll-site', volume name = 'site'

pod: 'jekyll', container: 'jekyll', volume name = 'site'

pod: 'jekyll', container: 'jekyll', mountPath = '/site'

pod: 'jekyll', container: 'jekyll', image = 'gcr.io/kodekloud/customimage/jekyll-serve'

pod: 'jekyll', uses volume called 'site' with pvc = 'jekyll-site'

pod: 'jekyll' uses label 'run=jekyll'

```jekyll.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: jekyll
  name: jekyll
  namespace: development  
spec:
  volumes:
    - name: site
      persistentVolumeClaim:
        claimName: jekyll-site
  containers:
  - image: gcr.io/kodekloud/customimage/jekyll-serve
    name: jekyll
    volumeMounts:
    - mountPath: "/site"
      name: site    
  initContainers:
  - name: copy-jekyll-site
    image: gcr.io/kodekloud/customimage/jekyll
    command: [ "jekyll", "new", "/site" ]
    volumeMounts:
    - mountPath: "/site"
      name: site
```

## ConfigMap
set context 'developer' with user = 'martin' and cluster = 'kubernetes' as the current context.
```
k config use-context developer
```

## Service
Service 'jekyll' uses targetPort: '4000', namespace: 'development'

Service 'jekyll' uses Port: '8080', namespace: 'development'

Service 'jekyll' uses NodePort: '30097', namespace: 'development'
```jekyll
apiVersion: v1
kind: Service
metadata:
  labels:
    run: jekyll
  name: jekyll
  namespace: development
spec:
  ports:
  - port: 8080
    protocol: TCP
    targetPort: 4000
    nodePort: 30097
  selector:
    run: jekyll
  type: NodePort
```

## Role
'developer-role', should have all(*) permissions for services in development namespace

'developer-role', should have all permissions(*) for persistentvolumeclaims in development namespace

'developer-role', should have all(*) permissions for pods in development namespace

```developer-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer-role
  namespace: development
rules:
- apiGroups:
  - ""
  resources:
  - pods
  - services
  - persistentvolumeclaims
  verbs:
  - '*'
```

## RoleBinding
create rolebinding = developer-rolebinding, role= 'developer-role', namespace = development
rolebinding = developer-rolebinding associated with user = 'martin'

```developer-rolebinding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-rolebinding
  namespace: development  
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: developer-role
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: martin  
```

kubectl auth can-i list pods --as=martin -n development
kubectl auth can-i list services --as=martin -n development
kubectl auth can-i list persistentvolumeclaims --as=martin -n development