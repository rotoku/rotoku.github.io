# mock_exams_1

## 1

```
kubectl run nginx-448839 \
    --image=nginx-alpine
```

## 2

```
kubectl create ns apx-z993845
```

## 3

```
kubectl create deployment httpd-frontend \
    --image=httpd:2.4-alpine \
    --replicas=3
```

## 4

```
kubectl run messaging \
    --image=redis:alpine \
    -l tier=msg
```

## 5

> edit name image name
> delete old pods (kubectl delete pod -l name=busybox-pod)

```

```

## 6

> por default cria como ClusterIP

```
kubectl expose deployment redis \
    --port=6379 \
    --name messaging-service \
    --namespace marketing
```

## 7

```
kubectl get pod webapp-color -o yaml > webapp-color.yaml
```

```webapp-color.yaml
  - env:
    - name: APP_COLOR
      value: green
```

```
kubectl replace -f webapp-color.yaml --force
```

## 8

```
kubectl create configmap cm-3392845 \
    --from-literal=DB_NAME=SQL3322 \
    --from-literal=DB_HOST=sql322.mycompany.com \
    --from-literal=DB_PORT=3306
```

## 9

```
kubectl create secret generic db-secret-xxdf \
    --from-literal=DB_Host=sql01 \
    --from-literal=DB_User=root \
    --from-literal=DB_Password=password123
```

## 10

```
kubectl get pods app-sec-kff3345 -o yaml > app-sec-kff3345.yaml
```

```app-sec-kff3345.yaml
    securityContext:
      capabilities:
        add: ["SYS_TIME"]
.
.
.
  securityContext:
    runAsUser: 0

```

```
kubectl replace -f app-sec-kff3345.yaml --force
```

## 11

```
kubectl get pods -A | grep "e-com-1123"
kubectl logs e-com-1123 -n e-commerce > /opt/outputs/e-com-113.logs
cat /opt/outputs/e-com-113.logs
```

## 12

```pv-analytics.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-analytics
spec:
  capacity:
    storage: 100Mi
  volumeMode: Filesystem
  accessModes:
    - ReadWriteMany
  hostPath:
    path: /pv/data-analytics
```

## 13

```
kubectl create deployment redis \
    --image=redis-alpine \
    --replicas=1

kubectl expose deployment redis \
    --name=redis \
    --port=6379 \
    --target-port=6379

```

```netpol.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: redis-access
  namespace: default
spec:
  podSelector:
    matchLabels:
      app: redis
  policyTypes:
  - Ingress
  ingress:
  - from:
    - podSelector:
        matchLabels:
          access: redis
    ports:
    - protocol: TCP
      port: 6379
```

## 14

```
apiVersion: v1
kind: Pod
metadata:
  name: sega
spec:
  containers:
  - image: busybox
    name: tails
    command:
      - sleep
      - "3600"
  - image: nginx
    name: sonic
    env:
      - name: NGINX_PORT
        value: "8080"
```
