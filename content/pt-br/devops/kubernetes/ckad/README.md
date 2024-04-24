# CKAD - Certified Kubernetes Application Developer

## 1. Introduction (17 minutes) - 17/04/2024

## 2. Core Concepts (2 hours 20 minutes) - 17/04/2024

```
# Edit POD definition
kubectl get pod <pod-name> -o yaml > pod-definition.yaml
OR
kubectl edit pod <pod-name>
```

### Please note that only the properties listed below are editable.

- spec.containers[*].image
- spec.initContainers[*].image
- spec.activeDeadlineSeconds
- spec.tolerations
- spec.terminationGracePeriodSeconds

```
## Como fazer o scale up ou down
kubectl scale --replicas=6 replicaset myapp-replicaset
kubectl scale --replicas=6 -f rs-definition.yaml
kubectl replace -f rs-definition.yaml
```

```
kubectl [command] [TYPE] [NAME] -o <output_format>
```

### Here are some of the commonly used formats:

- -o json Output a JSON formatted API object.
- -o name Print only the resource name and nothing else.
- -o wide Output in the plain-text format with any additional information.
- -o yaml Output a YAML formatted API object.

## 3. Configuration (3 hours 8 minutes) - 18/04/2024

```
docker build -t alpine-sleeper .
docker image ls
docker container ps
docker container ps -a
docker run -d -p <LOCAL_PORT>:<CONTAINER_PORT> <IMAGE>

---
FROM alpine

ENTRYPOINT [ "sleep" ]

CMD [ "10" ]
---

docker build -t alpine-sleeper .
docker image tag alpine-sleeper:latest rotoku/alpine-sleeper:latest
docker image push rotoku/alpine-sleeper:latest
```

### Environments

```
env:
  - name: APP_COLOR
    value: pink

env:
  - name: APP_COLOR
    valueFrom:
        configMapKeyRef:
            name: app-config
            key: APP_COLOR

envFrom:
  - configMapRef:
        name: app-config

volumes:
  - name: app-config-volume
    configMap:
        name: app-config

```

### ConfigMap

1. create

- kubectl create configmap app-config-from-literal --from-literal=APP_COLOR=blue
- kubectl create configmap app-config-from-file --from-file=applications.properties
- kubectl create -f configmap.yaml

2. inject

### Secrets

```
# Imperative
kubectl create secret generic \
  app-secret --from-literal=DB_HOST=mysql \
  --from-literal=DB_USER=user \
  --from-literal=DB_PASS=pass

kubectl create secret generic db-secret \
  --from-literal=DB_Host=sql01 \
  --from-literal=DB_User=root \
  --from-literal=DB_Password=password123 \
  --dry-run=client \
  -o yaml


kubectl create secret generic \
  app-secret --from-file=app_secret.properties

# Declarative
kubectl create -f secret-data.yaml

echo -n "mysql" | base64
echo -n "user" | base64
echo -n "pass" | base64

apiVersion: v1
kind: Secret
metadata:
  name: app-secret
data:
  DB_HOST: bXlzcWw=
  DB_USER: dXNlcg==
  DB_PASS: cGFzcw==


k get secrets
k describe secrets
k get secrets app-secret -o yaml

# decode
echo -n "cGFzcw==" | base64 --decode


# Example of usage
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres
  labels:
    app: postgres
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
        - name: postgresql
          image: postgres:14.9-bullseye
          ports:
            - containerPort: 5432
              protocol: TCP
---------------------------------------------------------
          envFrom:
          - secretRef:
              name: mysecret
---------------------------------------------------------
          env:
            - name: POSTGRES_PASSWORD
              valueFrom:
                secretKeyRef:
                  name: postgres-secrets-definition
                  key: POSTGRES_PASSWORD
---------------------------------------------------------
    volumes:
    - name: app-secret-volume
      secret:
        secretName: app-secret
---------------------------------------------------------


kubectl port-forward svc/sonarqube-service 9000:9000 --address=0.0.0.0
kubectl port-forward svc/postgres 5432:5432 --address=0.0.0.0
```

- Secrets are not encrypted. Only encoded

  - Do not check-in secrets objects to scm along with code.

- Secrets are not encrypted in ETCD

  - Enable encryption at rest

- Anyone able to create pods/deployments in the same namespace can access the secrets
  - Configure least-privilege access to Secrets - RBAC

* Consider third-party secrets store providers:
  - AWS Provider
  - Azure Provider
  - GCP Provider
  - Vault Provider

### Security

```docker
docker run --user-1001 ubuntu sleep 3600
docker run --privileged ubuntu
docker run --cap-add MAC_ADMIN ubuntu
docker run --cap-drop MAC_ADMIN ubuntu
```

```k8s
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
    type: front-end
spec:
  securityContext:
    runAsUser: 1000
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
---------------------------------------
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
    type: front-end
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      securityContext:
        capabilities:
          add: ["MAC_ADMIN"]
---------------------------------------
```

### Service Account

```
controlplane /var/rbac ➜  cat dashboard-sa-role-binding.yaml
---
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: ServiceAccount
  name: dashboard-sa # Name is case sensitive
  namespace: default
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

### Resource Requirements

```
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
    type: front-end
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      resources:
        requests:
          memory: "256Mi"
          cpu: 0.5
```

### Resource Limits

```
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
    type: front-end
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        - containerPort: 80
      resources:
        requests:
          memory: "256Mi"
          cpu: 0.5
        limits:
          memory: "512Mi"
          cpu: 1
```

```limit-range-cpu.yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: cpu-resource-constraint
spec:
  limits:
  - default:
      cpu: 500m
    defaultRequest:
      cpu: 500m
    max:
      cpu: "1"
    min:
      cpu: 100m
    type: Container
```

```limit-range-memory.yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: memory-resource-constraint
spec:
  limits:
  - default:
      memory: 1Gi
    defaultRequest:
      memory: 1Gi
    max:
      memory: 1Gi
    min:
      memory: 500Mi
    type: Container
```

```resource-quota.yaml
apiVersion: v1
kind: ResourceQuota
metadata:
  name: my-resource-quota
spec:
  hard:
    requests.cpu: 4
    requests.memory: 4Gi
    limits.cpu: 10
    limits.memory: 10Gi
```

CPU (Throtle):
0.1 = 100m = mili
1 = 1 aws vCPU

Memory (OOM and Terminate):
256 Mi = 268435446 = 268M

1 G (Gigabyte) = 1,000,000,000 bytes

1 Gi (Gibibyte) = 1,073,741,824 bytes
1 Mi (Mebibyte) = 1,048,576 bytes
1 Ki (Kibibyte) = 1,024 bytes

### Taints and Tolerations

```
## Removendo o Taint
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-

kubectl taint nodes node01 spray=mortein:NoSchedule

apiVersion: v1
kind: Pod
metadata:
  name: bee
spec:
  containers:
    - name: bee
      image: nginx
  tolerations:
    - key: "spray"
      operator: "Equal"
      value: "mortein"
      effect: "NoSchedule"
```

### Node Affinity

```blue-deployment.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: blue
    spec:
      containers:
      - image: nginx
        name: nginx
        resources: {}
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
              - matchExpressions:
                - key: color
                  operator: In
                  values:
                    - blue
status: {}
```

## 4. Multi-Container Pods (29 minutes) - 18/04/2024

Contêineres de inicialização
Em um pod com vários contêineres, espera-se que cada contêiner execute um processo que permaneça ativo enquanto durar o ciclo de vida do POD. Por exemplo, no pod de vários contêineres sobre o qual falamos anteriormente, que possui um aplicativo da web e um agente de registro, espera-se que ambos os contêineres permaneçam ativos o tempo todo. Espera-se que o processo em execução no contêiner do agente de log permaneça ativo enquanto o aplicativo Web estiver em execução. Se algum deles falhar, o POD será reiniciado.
Mas às vezes você pode querer executar um processo que seja executado até a conclusão em um contêiner. Por exemplo, um processo que extrai um código ou binário de um repositório que será usado pela aplicação web principal. Essa é uma tarefa que será executada apenas uma vez quando o pod for criado pela primeira vez. Ou um processo que espera que um serviço externo ou banco de dados esteja ativo antes que o aplicativo real seja iniciado. É aí que entra o initContainers.
Um initContainer é configurado em um pod como todos os outros contêineres, exceto que é especificado dentro de uma seção initContainers, assim:

```
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: ['sh', '-c', 'echo The app is running! && sleep 3600']
  initContainers:
  - name: init-myservice
    image: busybox
    command: ['sh', '-c', 'git clone <some-repository-that-will-be-used-by-application> ;']

```

Quando um POD é criado pela primeira vez, o initContainer é executado e o processo no initContainer deve ser concluído antes que o contêiner real que hospeda o aplicativo seja iniciado.
Você também pode configurar vários desses initContainers, como fizemos para contêineres com vários pods. Nesse caso, cada contêiner init é executado um de cada vez em ordem sequencial.
Se algum dos initContainers não for concluído, o Kubernetes reinicia o pod repetidamente até que o contêiner de inicialização seja bem-sucedido.

```
apiVersion: v1
kind: Pod
metadata:
  name: myapp-pod
  labels:
    app: myapp
spec:
  containers:
  - name: myapp-container
    image: busybox:1.28
    command: ['sh', '-c', 'echo The app is running! && sleep 3600']
  initContainers:
  - name: init-myservice
    image: busybox:1.28
    command: ['sh', '-c', 'until nslookup myservice; do echo waiting for myservice; sleep 2; done;']
  - name: init-mydb
    image: busybox:1.28
    command: ['sh', '-c', 'until nslookup mydb; do echo waiting for mydb; sleep 2; done;']

```

## 5. Observability (35 minutes) - 18/04/2024

```
apiVersion: v1
kind: Pod
metadata:
  labels:
    name: simple-webapp
  name: simple-webapp-1
spec:
  containers:
  - image: kodekloud/webapp-delayed-start
    name: simple-webapp
    ports:
    - containerPort: 8080
      protocol: TCP
    livenessProbe:
      httpGet:
        path: /live
        port: 8080
      periodSeconds: 1
      initialDelaySeconds: 80
```

## 6. POD Design (1 hour 19 minutes) - 19/04/2024

```

```

## 7. Services & Networking (1 hour 56 minutes) - 19/04/2024

```

```

## 8. State Persistence (59 minutes) - 19/04/2024

```

```

## 9. Security (2 hours 34 minutes)

```

```

## 10. Helm Fundamentals (21 minutes)

```
helm search hub wordpress
helm repo add bitnami https://charts.bitnami.com/bitnami
helm search repo bitnami/wordpress
helm repo list
helm search repo bitnami/drupal
helm pull --untar bitnami/drupal
helm install bravo ./drupal
helm list
helm uninstall bravo
helm pull --untar bitnami/apache
helm install mywebapp ./apache
helm uninstall mywebapp
```

## 11. Additional Practice - Kubernetes Challenges (Optional)

```

```

## 12. Certification Tips

```

```

## 13. Lightning Labs

```

```

## 14. Mock Exams

```

```
