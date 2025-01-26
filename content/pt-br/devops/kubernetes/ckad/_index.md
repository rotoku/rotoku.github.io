---
title: "CKAD"
linkTitle: "CKAD"
date: 2024-02-14
weight: 2
---

# CKAD - Certified Kubernetes Application Developer

## Exporting built container images in OCI format
```
docker image save -o alpine-lister-oci.tar alpine-lister:1.0.0
```


## 1. Introduction (17 minutes)

## 2. Core Concepts (2 hours 20 minutes)

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

## 3. Configuration (3 hours 8 minutes)

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

## 4. Multi-Container Pods (29 minutes)

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

## 5. Observability (35 minutes)

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

## 6. POD Design (1 hour 19 minutes)

### Labels, Selectors and Annotations

```
kubectl get pods --selector env=dev
kubectl get pods --selector bu=finance
kubectl get all --selector env=prod
kubectl get all --selector env=prod,bu=finance,tier=frontend
```

### Rolling Updates & Rollbacks in Deployments

```
kubectl create deployment nginx --image=nginx:1.16 --replicas=5 --dry-run=client -o yaml > deployment-definition.yaml
kubectl create -f deployment-definition.yaml
kubectl rollout status deployment nginx
kubectl rollout history deployment nginx
kubectl rollout history deployment nginx --revision=1
kubectl set image deployment nginx nginx=nginx:1.17 --record ## Flag --record has been deprecated, --record will be removed in the future
kubectl rollout history deployment nginx
kubectl edit deployments.apps nginx --record
kubectl rollout history deployment nginx --revision=3
kubectl rollout undo deployment nginx
kubectl rollout undo deployment nginx --to-revision=2
```

### Deployment Strategy - Blue Green

```

```

### Deployment Strategy - Canary

```

```

### Jobs

```job-definition.yaml
apiVersion: batch/v1
kind: Job
metadata:
  name: throw-dice-job
spec:
  completions: 3
  parallelism: 3
  template:
    spec:
      containers:
        - name: throw-dice-job
          image: kodekloud/throw-dice
      restartPolicy: Never
  backoffLimit: 4
```

### CronJobs

```
apiVersion: batch/v1
kind: CronJob
metadata:
  name: throw-dice-cron-job
spec:
  schedule: "30 21 * * *"
  jobTemplate:
    spec:
      completions: 3
      parallelism: 3
      template:
        spec:
          containers:
            - name: throw-dice-job
              image: kodekloud/throw-dice
          restartPolicy: Never
      backoffLimit: 4
```

## 7. Services & Networking (1 hour 56 minutes)

Services em K8s habilita a comunicação externa ao cluster para serviços internos e também comunicação entre serviços internos.

## Services Types

- ClusterIP
- NodePort
- LoadBalancer

```
kubectl create ingress <ingress-name> --rule="host/path=service:port"

kubectl create ingress ingress-test --rule="wear.my-online-store.com/wear*=wear-service:80"
```

```service-definition-NodePort.yaml
apiVersion: v1
kind: Service
metadata:
  name: java-webapp-service
  labels:
    app: java-webapp
    tier: frontend
spec:
  type: NodePort
  ports:
    - targetPort: 8080 ## port in pod
      port: 8080 ## port for service match port pod
      nodePort: 30008 ## port expose externally
  selector:
    app: java-webapp
    tier: frontend
```

Diferentes controladores de ingresso têm diferentes opções que podem ser usadas para personalizar a forma como funcionam. O controlador NGINX Ingress tem muitas opções que podem ser vistas aqui. Gostaria de explicar uma dessas opções que usaremos em nossos laboratórios. A opção Reescrever destino.

## 8. State Persistence (59 minutes)

```
persistentVolumeReclaimPolicy: Recycle | Retain | Delete

accessModes: ReadWriteOnce | ReadOnlyMany | ReadWriteMany | ReadWriteOncePod
```

### Static Provisioning

```
aws ec2 create-volume \
    --volume-type ext4 \
    --size 1 \
    --availability-zone us-east-1a \
    --tag-specifications 'ResourceType=volume,Tags=[{Key=Name,Value=data-volume}]'
```

```output.json
{
    "AvailabilityZone": "us-east-1a",
    "Tags": [],
    "Encrypted": true,
    "VolumeType": "gp2",
    "VolumeId": "vol-1234567890abcdef0",
    "State": "creating",
    "Iops": 240,
    "SnapshotId": "",
    "CreateTime": "YYYY-MM-DDTHH:MM:SS.000Z",
    "Size": 80
}
```

```
apiVersion: v1
kind: Pod
metadata:
  name: random-number-generator
spec:
  containers:
    - name: alpine
      image: alpine
      command:
        - "/bin/sh"
        - "-c"
      args: ["shuf -i 0-100 -n 1 >> /opt/number.out;"]
      volumeMounts:
        - mountPath: /opt
          name: data-volume
  volumes:
    - name: data-volume
      awsElasticBlockStore:
        volumeID: vol-1234567890abcdef0
        fsType: ext4
```

### Dynamic Provisioning (PV is create automaticamente)

1. Create StorageClass
2. Create PVC with storageClassName matching with name define in StorageClass
3. Create a POD with claimName matching with name define in pvc

### Stateful Sets

```
kubectl create -f /media/rkumabe/DATA/git/rotoku/rotoku.github.io/content/pt-br/devops/kubernetes/ckad/state-persistence/statefulset-definition.yaml
kubectl scale statefulset mysql --replicas=5
kubectl scale statefulset mysql --replicas=3
kubectl delete statefulset mysql
```

### Headless Services

```

```

## 9. Security (2 hours 34 minutes)

### Basic Authentication

> Setup basic authentication on Kubernetes (Deprecated in 1.19)

```/etc/kubernetes/manifests/kube-apiserver.yaml
apiVersion: v1
kind: Pod
metadata:
  name: kube-apiserver
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-apiserver
    - --authorization-mode=Node,RBAC
      <content-hidden>
    - --basic-auth-file=/tmp/users/user-details.csv
    image: k8s.gcr.io/kube-apiserver-amd64:v1.11.3
    name: kube-apiserver
    volumeMounts:
    - mountPath: /tmp/users
      name: usr-details
      readOnly: true
  volumes:
  - hostPath:
      path: /tmp/users
      type: DirectoryOrCreate
    name: usr-details

```

#### Create the necessary roles and role bindings for these users:

```
kind: Role
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  namespace: default
  name: pod-reader
rules:
- apiGroups: [""] # "" indicates the core API group
  resources: ["pods"]
  verbs: ["get", "watch", "list"]

```

```
# This role binding allows "jane" to read pods in the "default" namespace.
kind: RoleBinding
apiVersion: rbac.authorization.k8s.io/v1
metadata:
  name: read-pods
  namespace: default
subjects:
- kind: User
  name: user1 # Name is case sensitive
  apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: Role #this must be Role or ClusterRole
  name: pod-reader # this must match the name of the Role or ClusterRole you wish to bind to
  apiGroup: rbac.authorization.k8s.io
```

```curl test
curl -v -k https://localhost:6443/api/v1/pods -u "user1:password123"
```

### KubeConfig

```
curl https://127.0.0.1:37085/api/v1/pods --key admin.key --cert admin.crt --cacert ca.crt
```

```role-definition.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer
  namespace: default
rules:
- apiGroups:
  - ""
  resources:
  - pods
  verbs:
  - list
  - create
  - delete
```

```rolebinding-definition.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: dev-user-binding
  namespace: default
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: developer
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: dev-user
```

```another-role-definition.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer
  namespace: blue
rules:
  - apiGroups:
    - ""
    resourceNames:
    - dark-blue-app
    resources:
    - pods
    verbs:
    - get
    - watch
    - create
    - delete
  - apiGroups:
    - apps
    resources:
    - deployments
    verbs:
    - create
```

```michelle-cluster-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: michelle-cluster-role
rules:
- apiGroups:
  - ''
  resources:
  - 'nodes'
  verbs:
  - '*'
```

```michelle-cluster-role-binding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: michelle-cluster-role-binding
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: michelle-cluster-role
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: michelle
```

```michelle-cluster-role-storage-admin.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: storage-admin
rules:
- apiGroups:
  - 'storage.k8s.io'
  resources:
  - 'persistentvolumes'
  verbs:
  - '*'
- apiGroups:
  - 'storage.k8s.io'
  resources:
  - 'storageclasses'
  verbs:
  - '*'

```

```michelle-cluster-role-storage-admin-binding.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: michelle-storage-admin
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: ClusterRole
  name: storage-admin
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: michelle
```

```view enabled admission controllers
kubectl exec kube-apiserver-kumabes-cluster-control-plane -n kube-system -- kube-apiserver -h | grep enable-admission-plugins
```

```
kubectl create secret tls webhook-server-tls -n webhook-demo --cert=/root/keys/webhook-server-tls.crt --key=/root/keys/webhook-server-tls.key
```

```
curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/
amd64/kubectl-convert

chmod +x kubectl-convert

mv kubectl-convert /usr/local/bin/kubectl-convert

kubectl convert -f ingress-old.yaml --output-version networking.k8s.io/v1 > ingress-new.yaml

kubectl apply -f ingress-new.yaml
```

### Custom Resource Definition

```crd.yaml
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: internals.datasets.kodekloud.com
spec:
  group: datasets.kodekloud.com
  versions:
    - name: v1
      served: true
      storage: true
      schema:
        openAPIV3Schema:
          type: object
          properties:
            spec:
              type: object
              properties:
                internalLoad:
                  type: string
                range:
                  type: integer
                percentage:
                  type: string
  scope: Namespaced
  names:
    plural: internals
    singular: internal
    kind: Internal
    shortNames:
    - int
```

```custom.yaml
kind: Internal
apiVersion: datasets.kodekloud.com/v1
metadata:
  name: internal-space
  namespace: default
spec:
  internalLoad: "high"
  range: 80
  percentage: "50"

```

### Custom Controller

```
git clone https://github.com/kubernetes/sample-controller
cd sample-controller
go build -o sample-controller .
./sample-controller -kubeconfig=$HOME/.kube/config

Para distribuir é necessário colocar o compilado go em uma imagem docker e fazer o deploy em um pod;


```

### Operator Framework

```
https://operatorhub.io
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
