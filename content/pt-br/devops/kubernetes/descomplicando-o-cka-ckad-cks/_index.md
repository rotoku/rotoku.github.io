---
title: "Descomplicando o CKA CKAD CKS"
linkTitle: "descomplicando-o-cka-ckad-cks"
date: 2024-10-03
weight: 9
---

## Pré-requisitos de ambiente

- instalação do docker

```bash
curl -fsSL https://get.docker.com | bash
```

- instalação do kind

```bash
# Kind: https://kind.sigs.k8s.io/docs/user/quick-start/#installing-from-release-binaries
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.13.0/kind-linux-amd64

chmod +x ./kind

mv kind /usr/local/bin

kind create cluster
```

- instalação do kubectl

```bash
# https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/
curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg
echo "deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list
apt-get update
apt-get install -y kubectl

## Instalando via binários
curl -LO "https://dl.k8s.io/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl.sha256"
echo "$(cat kubectl.sha256)  kubectl" | sha256sum --check
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
```

- Alias e Autocomplete

```bash
# Link: https://kubernetes.io/docs/reference/kubectl/cheatsheet/

## autocomplete:
source <(kubectl completion bash)
echo "source <(kubectl completion bash)" >> ~/.bashrc
## Alias:
alias k=kubectl
complete -F __start_kubectl k

## vim
cat <<EOF > ~/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
EOF


export d="--dry-run=client -o yaml"
```

## Pod

```meu-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  containers:
    - name: nginx
      image: nginx
      ports:
        -containerPort: 80
```

```
kubectl apply -f meu-pod.yaml
kubectl describe pod meu-pod.yaml
kubectl explain pod
kubectl explain pod.spec
kubectl explain pod.spec --recursive
kubectl run nginx --image nginx --dry-run=client -o yaml
kubectl edit pod meu-pod
kubectl explain pod.spec.containers
```

```
kubectl replace --force -f pod.yaml
kubectl run sleep --image busybox --dry-run=client -o yaml -- sleep 1000 > sleep.yaml
kubectl delete pod sleep --force --grace-period 0
kubectl replace --force -f sleep.yaml --force --grace-period 0
```

> O parâmetro --grace-period em Kubernetes é usado para especificar o período de tempo durante o qual o sistema aguardará antes de forçar a exclusão de um recurso, como um pod. O valor é especificado em segundos. Quando você define --grace-period 0, está instruindo o Kubernetes a forçar a exclusão do recurso imediatamente. Isso é útil quando você precisa remover um recurso rapidamente, mas deve ser usado com cuidado, pois pode resultar em um encerramento abrupto do processo, o que pode levar a um estado inconsistente ou a perda de dados.

### Docker vs Kubernetes
Comparativo entre o campo de command para docker e Kubernetes:

|Descrição| Docker | Kubernetes |
|----------|:-------------:|------:|
| comando executado no contêiner | Entrypoint | command |
| argumentos passados para o contêiner | Cmd | args |

#### Uso
```
command: ["/bin/sh"]
args: ["-c", "while true; do echo hello; sleep 10;done"]
```
| Image Entrypoint | Image Cmd | Container command | Container args | Command run |
|----------|:-------------:|------:|------:|------:|
| [/echo] | [foo] | <not set> | <not set> | [echo foo] |
| [/echo] | [foo] | [/printf] | <not set> | [printf] |
| [/echo] | [foo] | <not set> | [bar] | [echo bar] |
| [/echo] | [foo] | [/printf] | [bar] | [printf bar] |

#### Manifesto Yaml
```pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: command
spec:
  containers:
    - name: command
      image: nginx
      ports:
        - containerPort: 80      
      command: 
        - printf
      args:
        - "Hello World!"  

```

```pod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: command
spec:
  containers:
    - name: command
      image: nginx
      ports:
        - containerPort: 80      
      command: 
        - /bin/sh
        - -c
        - env
        - "sleep 1d"
```

## ReplicaSet

## Deployment
Manage the rollout of one or many resources.
  
 Valid resource types include:

  *  deployments
  *  daemonsets
  *  statefulsets

Examples:
```
  # Rollback to the previous deployment
  kubectl rollout undo deployment/abc
  
  # Check the rollout status of a daemonset
  kubectl rollout status daemonset/foo
  
  # Restart a deployment
  kubectl rollout restart deployment/abc
  
  # Restart deployments with the app=nginx label
  kubectl rollout restart deployment --selector=app=nginx

  kubectl rollout undo --to-revision 2 deployment/nginx-deployment
```
Available Commands:
  history       View rollout history
  pause         Mark the provided resource as paused
  restart       Restart a resource
  resume        Resume a paused resource
  status        Show the status of the rollout
  undo          Undo a previous rollout


## StatefulSet

## Persistent Volumes
```primeiropv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: primeiropv
spec:
  storageClassName: "" 
  persistentVolumeReclaimPolicy: Retain # [Retain | Recycle | Delete]
    # Retain -- Precisa de uma ação manual
    # Recycle -- Basico (rm -rf /thevolume/*)
    # Delete -- utilizando AWS EBS, GCE PD, Azure Disk, ou OpenStack Cinder o volume é deletado
  volumeMode: Filesystem # [Filesystem | Block]
  capacity:
    storage: 1Gi
  accessModes: # [ReadWriteOnce | ReadOnlyMany | ReadWriteMany]
    - ReadWriteOnce
  hostPath:
    path: "/volume"
    type: "" # [ FileOrCreate | DirectoryOrCreate ]
      # DirectoryOrCreate = Se nada existir no caminho fornecido, um diretório vazio será criado lá conforme necessário com a permissão definida como 0755, tendo o mesmo grupo e propriedade do Kubelet.
      # FileOrCreate = Se nada existir no caminho fornecido, um arquivo vazio será criado lá conforme necessário com a permissão definida como 0644, tendo o mesmo grupo e propriedade do Kubelet.
```
## Persistent Volumes Claim
```primeiropvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: primeiropvc
  namespace: day1
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
```
## pod
```
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
  namespace: day1
spec:
  nodeSelector:
    kubernetes.io/os: linux
  containers:
  - image: nginx
    name: nginx
    resources: {}
    volumeMounts:
      - mountPath: /data
        name: usandopvc
  dnsPolicy: ClusterFirst
  restartPolicy: Always
  volumes:
    - name: usandopvc
      persistentVolumeClaim:
        claimName: primeiropvc
```
## EmptyDir
é um volume ephemero, compartilhar volume entre 2 containers em um pod
```
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
  namespace: day1
spec:
  nodeSelector:
    kubernetes.io/os: linux
  containers:
  - image: nginx
    name: nginx
    volumeMounts:
      - mountPath: /usr/share/nginx/html
        name: empty
  - image: busybox
    name: busybox
    volumeMounts:
      - mountPath: /html
        name: empty
    command:
    - "/bin/sh"
    - "-c"    
    args:
    - while true; do
        date +"%Y%m%dT%H%M%S" >> /html/index.html;
        sleep 1;
      done  
  volumes:
    - name: empty
      emptyDir: {}
```

## ConfigMap

``` export configmap as environments
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
  namespace: day1
spec:
  nodeSelector:
    kubernetes.io/os: linux
  containers:
  - image: nginx
    name: nginx
    envFrom:
    - configMapRef:
        name: primeiro-cm
```

```config map as field
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
  namespace: day1
spec:
  nodeSelector:
    kubernetes.io/os: linux
  containers:
  - image: nginx
    name: nginx
    env:
    - name: MEU_IP
      valueFrom:
        configMapKeyRef:
          name: primeiro-cm
          key: ip
```

```config map as volume
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
  namespace: day1
spec:
  nodeSelector:
    kubernetes.io/os: linux
  containers:
  - image: nginx
    name: nginx
    volumeMounts:
      - name: configmap-volume
        mountPath: /data
  volumes:
    - name: configmap-volume
      configMap:
        name: primeiro-cm
```

```config map as volume for specific values
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
  namespace: day1
spec:
  nodeSelector:
    kubernetes.io/os: linux
  containers:
  - image: nginx
    name: nginx
    volumeMounts:
      - name: configmap-volume
        mountPath: /data
  volumes:
    - name: configmap-volume
      configMap:
        name: primeiro-cm
        items:
          key: ip
          path: meuip.config
```

```
kubectl create configmap segundo-cm --from-literal=ip=10.0.0.2
kubectl create configmap segundo-cm --from-file=nginx.conf=/opt/nginx/nginx.conf
kubectl edit configmap segundo-cm
```

```immutable
apiVersion: v1
data:
  ip: 10.0.0.2
immutable: true
kind: ConfigMap
metadata:
  name: primeiro-cm
```

## Secrets
```secrets.yaml
apiVersion: v1
kind: Secret
metadata:
  name: minha-secret
data:
  user: YWRtaW4=
  pass: c2VuaGFzZWd1cmE=

```
- docker
- tls
- generic

```
kubectl create secret generic segunda-secret --from-literal=user=admin --from-literal=pass=senhasegura
```

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    resources: {}
    envFrom:
      - secretRef:
          name: minha-secret
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    env:
    - name: MEU_USER
      valueFrom:
        secretKeyRef:
          key: user
          name: minha-secret
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  volumes:
  - name: secret-volume
    secret:
      secretName: minha-secret
  containers:
  - image: nginx
    name: nginx
    volumeMounts:
      - mountPath: /data
        name: secret-volume
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

```
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: nginx
  name: nginx
spec:
  volumes:
  - name: secret-volume
    secret:
      secretName: minha-secret
      items:
        - key: user
          path: users.conf
  containers:
  - image: nginx
    name: nginx
    volumeMounts:
      - mountPath: /data
        name: secret-volume
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

- a secret pode ser immutable: true
- pode definir modo de acesso:
```
  volumes:
  - name: secret-volume
    secret:
      defaultMode: 0400
      secretName: minha-secret
      items:
        - key: user
          path: users.conf
```
## Build Docker
```
vim /root/Dockerfile
docker build -t pinger .
docker image ls
docker run --name my-ping pinger
docker image build -t local-registry:5000/pinger .
docker image ls
docker tag pinger local-registry:5000/pinger
docker image ls
docker push local-registry:5000/pinger
docker tag pinger local-registry:5000/pinger:v1
docker image build -t pinger:v1 .
docker image ls
docker push local-registry:5000/pinger:v1
```

> There are existing Pods in Namespace space1 and space2. We need a new NetworkPolicy named np that restricts all Pods in Namespace space1 to only have outgoing traffic to Pods in Namespace space2 . Incoming traffic not affected. The NetworkPolicy should still allow outgoing DNS traffic on port 53 TCP and UDP.

```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: np
  namespace: space1
spec:
  podSelector: {}
  policyTypes:
  - Egress
  egress:
  - ports:
    - port: 53
      protocol: TCP
    - port: 53
      protocol: UDP
  - to:
    - namespaceSelector:
        matchLabels:
          kubernetes.io/metadata.name: space2
```



alias ll="ls -lrth --color"
alias kaf="kubectl apply -f"
export do="--dry-run=client -o yaml"