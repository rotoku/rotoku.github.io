---
title: "CKA"
linkTitle: "CKA"
date: 2024-02-14
weight: 1
---

# CKA - Certified Kubernetes Administrator

## Safe time with alias
```
alias k="kubectl"
alias kaf="kubectl apply -f"
alias kcf="kubectl create -f"
export do="--dry-run=client -o yaml"

k config get-contexts
k config get-contexts -o name
k config current-context
k config use-context <CONTEXT_NAME>

k get pods -A --sort-by=.metadata.creationTimestamp
```

## Agendamento Manual
```
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  nodeName: worker01
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80
```

## Labels and Selectors
```
k get pods --selector env=dev
k get pods --selector bu=finance
k get all --selector env=prod
k get pod --selector env=prod,bu=finance,tier=frontend
```

## Taints and Tolerations
```
# kubectl taint nodes node-name key=value:taint-effect
# taint-effect: NoSchedule | PreferNoSchedule | NoExecute
# Create a taint on node01 with key of spray, value of mortein and effect of NoSchedule?
kubectl taint nodes node01 spray=mortein:NoSchedule

# Create another pod named bee with the nginx image, which has a toleration set to the taint mortein?
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: bee
  name: bee
spec:
  tolerations:
  - key: "spray"
    operator: "Equal"
    value: "mortein"
    effect: "NoSchedule"
  containers:
  - image: nginx
    name: bee
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}


# Remove the taint on controlplane, which currently has the taint effect of NoSchedule.
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```

## Node Affinity
```
# kubectl label [--overwrite] (-f FILENAME | TYPE NAME) KEY_1=VAL_1 ... KEY_N=VAL_N [--resource-version=version] [options]
kubectl label node node01 color=blue

# Set Node Affinity to the deployment to place the pods on node01 only.
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: blue
  name: blue
spec:
  replicas: 3
  selector:
    matchLabels:
      app: blue
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: blue
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: color
                operator: In
                values:
                - blue
      containers:
      - image: nginx
        name: nginx

# Create a new deployment named red with the nginx image and 2 replicas, and ensure it gets placed on the controlplane node only.
# Use the label key - node-role.kubernetes.io/control-plane - which is already set on the controlplane node.
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: red
  name: red
spec:
  replicas: 2
  selector:
    matchLabels:
      app: red
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      labels:
        app: red
    spec:
      affinity:
        nodeAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
            nodeSelectorTerms:
            - matchExpressions:
              - key: node-role.kubernetes.io/control-plane
                operator: Exists
      containers:
      - image: nginx
        name: nginx
```

## Resource Limits
```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - image: nginx
    name: bee
    resources:
      requests:
        memory: 512Mi
      limits:
        memory: 1Gi
```

## DaemonSets
```
apiVersion: apps/v1
kind: DaemonSet
metadata:
  creationTimestamp: null
  labels:
    app: elasticsearch
  name: elasticsearch
  namespace: kube-system
spec:
  selector:
    matchLabels:
      app: elasticsearch
  template:
    metadata:
      labels:
        app: elasticsearch
    spec:
      containers:
      - image: registry.k8s.io/fluentd-elasticsearch:1.20
        name: fluentd-elasticsearch
```

## Static PODs
```
# Location of static pods /etc/kubernetes/manifests
ps -ef |  grep /usr/bin/kubelet
grep -i staticpod /var/lib/kubelet/config.yaml
cd /etc/just-to-mess-with-you
rm -rf greenbox.yaml
```

## Multiple Schedulers
> é possível ter especifico scheduler por objeto
```
wget https://storage.googleapis.com/kubernetes-release/release/v1.12.0/bin/linux/amd64/kube-scheduler
```

```kube-scheduler.service
ExecStart=/usr/local/bin/kube-scheduler \
    --config=/etc/kubernetes/config/kube-scheduler.yaml
```

```my-custom-scheduler.service
ExecStart=/usr/local/bin/kube-scheduler \
    --config=/etc/kubernetes/config/my-custom-scheduler.yaml
``` 

```my-custom-scheduler.yaml
apiVersion: kubescheduler.config.k8s.io/v1
kind: KubeSchedulerConfiguration
profiles:
- schedulerName: my-scheduler
```

```/etc/kubernetes/manifests/kube-scheduler.yaml
apiVersion: v1
kind: Pod
metadata:
  name: kube-scheduler
  namespace: kube-system
spec:
  containers:
  - command:
    - kube-scheduler
    - --address=127.0.0.1
    - --kubeconfig=/etc/kubernetes/scheduler.conf
    ## set it for leader
    - --leader-elect=true
    image: k8s.gcr.io/kube-scheduler-amd64:v1.11.3
    name: kube-scheduler
```

```
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
  - image: nginx
    name: bee
    resources:
      requests:
        memory: 512Mi
      limits:
        memory: 1Gi
  schedulerName: my-custom-scheduler
```

```
kubectl get events -o wide
```


## Configuring Scheduler Profiles
- Scheduling Queue
- Filtering
- Scoring
- Binding
```

```

## Logging and Monitoring
```
kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml

kubectl logs -f nginx

kubectl logs -f web-app1 -c nginx
```

## Para instalação do k8s vanilla utilizar devops/kubernetes/files/05/README.md
```

```

## Persistent Volumes and Persistent Volume Claims
```

```

## Install ETCD
```
# 1. Download Binaries
curl -L https://github.com/etcd-io/etcd/releases/download/v3.3.11/etcd-v3.3.11-linux-amd64.tar.gz -o etcd-v3.3.11-linux-amd64.tar.gz
# 2. Extract
tar xzvf etcd-v3.3.11-linux-amd64.tar.gz
# 3. Move etcdctl to /usr/local/bin/
sudo cp ./etcd-v3.3.11-linux-amd64/etcdctl /usr/local/bin/
# 4. Give permission to etcdctl
sudo chmod +x /usr/local/bin/etcdctl
# 5. Check access
etcdctl --version
```

## ETCD Backup in Kubernetes
> normalmente o etcdctl esta instalado no workers, mas pode ser que no seu ambiente o mesmo esteja instalado no control-plane (master node)
> as informações dos certificados devem ser do master node "kubectl describe pod -n kube-system etcd-kumabes-k8s-cluster-control-plane"
```
ETCDCTL_API=3 etcdctl \
    --endpoints=https://[172.18.0.5]:2379 \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    snapshot save /home/rkumabe/manifests/backup.db
```

## ETCD Restore in Kubernetes
```

```

## Criar Cronjob e testar com um job
```

```

## Service Account
```
kubectl create serviceaccount podreader
```

## Role
```
# kubectl create role NAME --verb=verb --resource=resource.group/subresource [--resource-name=resourcename]
# Create a role named "foo" with API Group specified
# kubectl create role foo --verb=get,list,watch --resource=rs.apps
kubectl create role podreader --verb=get,list,watch --resource=pods
```

## Role Binding
```
# kubectl create rolebinding NAME --clusterrole=NAME|--role=NAME [--user=username] [--group=groupname]
kubectl create rolebinding podreaderbinding \
  --serviceaccount=default:podreader \
  --role=podreader
```

## Check access with service account
```
kubectl auth can-i create pods
kubectl auth can-i create pods --as system:serviceaccount:default:podreader

kubectl auth can-i get pods
kubectl auth can-i get pods --as system:serviceaccount:default:podreader

kubectl auth can-i watch pods --as system:serviceaccount:default:podreader
kubectl auth can-i list pods --as system:serviceaccount:default:podreader
kubectl auth can-i delete pods --as system:serviceaccount:default:podreader

# Check to see if I can read pod logs
kubectl auth can-i get pods --subresource=log
  
# Check to see if I can access the URL /logs/
kubectl auth can-i get /logs/
  
# List all allowed actions in namespace "foo"
kubectl auth can-i --list --namespace=foo
```

## Cleanup
```
kubectl delete rolebinding podreaderbinding && sleep 10
kubectl delete role podreader && sleep 10
kubectl delete serviceaccount podreader && sleep 10 && echo "Finish"
```