```private-reg-cred.yaml
k create secret docker-registry private-reg-cred \
    --docker-username=dock_user \
    --docker-password=dock_password \
    --docker-email=dock_user@myprivateregistry.com \
    --docker-server=myprivateregistry.com:5000
```

```nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  imagePullSecrets:
  - name: private-reg-cred  
  containers:
  - image: myprivate-registry.io:5000/nginx
    name: nginx
    ports:
      - containerPort: 80
```

```
cat /usr/include/linux/capability.h


docker run --user=1001 ubuntu sleep 3600

docker run --cap-add MAC_ADMIN ubuntu
```


```nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
      - containerPort: 80
    securityContext:
      runAsUser: 1000
      capabilities:
        add: ["MAC_ADMIN"]
``` 

## Networking Policy
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internal-policy
  namespace: default
spec:
  ingress:
  - {}  
  egress:
  - to:
    - podSelector:
        matchLabels:
          name: mysql
    ports:
    - port: 3306
      protocol: TCP
  - to:
    - podSelector:
        matchLabels:
          name: payroll
    ports:
    - port: 8080
      protocol: TCP
  - ports:
    - port: 53
      protocol: UDP
  - ports:
    - port: 53
      protocol: TCP
  podSelector:
    matchLabels:
      name: internal
  policyTypes:
  - Ingress
  - Egress
```  