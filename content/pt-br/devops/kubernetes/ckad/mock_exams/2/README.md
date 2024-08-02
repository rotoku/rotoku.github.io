# mock_exams_2

## 1

```
kubectl create deployment my-webapp --image=nginx --replicas=2 --dry-run=client -o yaml > my-webapp.yaml
kubectl expose deployment my-webapp --name front-end-service --port 80 --type NodePort --dry-run=client -o yaml > front-end-service.yaml
```

## 2

```
kubectl taint node node01 app_type=alpha:NoSchedule
kubectl run alpha --image=redis --dry-run=client -o yaml > alpha.yaml

spec:
  tolerations:
    - effect: NoSchedule
      key: app_type
      value: alpha
```

## 3

```
kubectl label node controlplane app_type=beta
kubectl get node controlplane --show-labels
kubectl create deployment beta-apps --image=nginx --replicas=3 --dry-run=client -o yaml > beta-apps.yaml

spec:
  affinity:
    nodeAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
        nodeSelectorTerms:
        - matchExpressions:
          - key: app_type
            operator: In
            values: ["beta"]
```

## 4

```
kubectl get svc
kubectl create ingress ingress --rule="ckad-mock-exam-solution.com/video*=my-video-service:8080" --dry-run=client -o yaml > ingress.yaml

apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
  name: ingress
spec:
  rules:
  - host: ckad-mock-exam-solution.com
    http:
      paths:
      - backend:
          service:
            name: my-video-service
            port:
              number: 8080
        path: /video
        pathType: Prefix
```

## 5

```
.
.
.
    readinessProbe:
      httpGet:
        path: /ready
        port: 8080
.
.
.

kubectl replace -f pod-with-rprobe.yaml --force
```

## 6

```
kubectl run nginx1401 --image=nginx --dry-run=client -o yaml > nginx1401.yaml
.
.
.
    livenessProbe:
      exec:
        command: ["ls /var/www/html/probe"]
      initialDelaySeconds: 10
      periodSeconds: 60
.
.
.


```

## 7

```
apiVersion: batch/v1
kind: Job
metadata:
  name: whalesay
spec:
  completions: 10
  template:
    spec:
      containers:
        - name: whalesay
          image: docker/whalesay
          command:
            - sh
            - -c
            - "cowsay I am going to ace CKAD!"
      restartPolicy: Never
  backoffLimit: 6
```

## 8

```
apiVersion: v1
kind: Pod
metadata:
  name: multi-pod
spec:
  containers:
    - name: jupiter
      image: nginx
      env:
        - name: type
          value: planet
    - name: europa
      image: busybox
      env:
        - name: type
          value: moon
      command:
        - "/bin/sh"
        - "-c"
        - "sleep 4800"

```

## 9

```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: custom-volume
spec:
  capacity:
    storage: 50Mi
  accessModes:
  - ReadWriteMany
  persistentVolumeReclaimPolicy: Retain
  hostPath:
    path: /opt/data
```
