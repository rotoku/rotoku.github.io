# lightning-lab-1_2

## Testando conectividade em uma determinada porta

```bash
nc -v -z -w 2 localhost 80
```

## 123

```default-deny.yaml
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  labels:
    name: default-deny
  name: default-deny
spec:
  podSelector:
    matchLabels:
      run: ssecure-pod
  policyTypes:
    - Ingress
  ingress:
    - from:
      - podSelector:
          matchLabels:
            name: webapp-color
      ports:
        - protocol: TCP
          port: 80
```

## 123

```webapp-color.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: webapp-color
  name: webapp-color
spec:
  containers:
    - name: webapp-color
      image: nginx:alpine
```

```secure-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: secure-pod
  name: secure-pod
spec:
  containers:
    - name: secure-pod
      image: nginx:alpine
```

```secure-service.yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    name: secure-service
  name: secure-service
spec:
  ports:
  - name: http
    port: 80
    protocol: TCP
    targetPort: 80
  type: ClusterIP
```
