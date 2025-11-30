# Cluster Maintenance

## Operating System Upgrades
5 minutes until kube-api reschedule in another node.
### Secure way manually
```
kubectl drain node01
kubectl drain node01 --ignore-daemonsets
kubectl drain node01 --ignore-daemonsets --force

kubectl uncordon node01  (voltar agendamento)
kubectl cordon node01 (sem agendamento)
```

### Releases
- semantic version
- k8s works with beta, alpha and stable
- kube-apiserver - X
- controller-manager - X-1
- kube-scheduler - X-1
- kubectl - X+1 > X-1
- kubelet - X-2
- kube-proxy - X-2

> K8S: support only 3 versions of release

There different versions, because are another project structure
- etcd
- coredns 
## Cluster Upgrade Process
```
- upgrade using k8s manager provider
- upgrade using kubeadm

### Strategy 1
- upgrade first master node
- upgrade all worker nodes

### Strategy 2
- upgrade first master node
- upgrade each worker nodes per time

### Strategy 3
- upgrade first master node
- upgrade worker node add new node

### update kubeadm
kubeadm upgrade plan
apt upgrade -y kubeadm=1.12.0-00
kubeadm upgrade apply v1.12.0

### update kubelet
apt upgrade -y kubelet=1.12.0-00
systemctl restart kubelet

### update worker node
kubectl drain node-1
apt upgrade -y kubeadm=1.12.0-00
apt upgrade -y kubelet=1.12.0-00
kubeadm upgrade node config --kubelet-version v1.12.0
systemctl restart kubelet
kubectl uncordon node-1
```
### Practice Test Cluster Upgrade Process
```
kubectl drain controlplane --ignore-daemonsets
vim /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt-cache madison kubeadm

1.31.4-1.1

sudo apt-get install kubeadm=1.31.4-1.1

sudo kubeadm upgrade plan v1.31.4
sudo kubeadm upgrade apply v1.31.4

sudo apt-get install kubelet=1.31.4-1.1
sudo systemctl daemon-reload
sudo systemctl restart kubelet

sudo kubectl uncordon controlplane


-------------------------

kubectl drain node01 --ignore-daemonsets
vim /etc/apt/sources.list.d/kubernetes.list
sudo apt update
sudo apt-cache madison kubeadm

1.31.4-1.1

sudo apt-get install kubeadm=1.31.4-1.1 kubelet=1.31.4-1.1 -y

sudo kubeadm upgrade plan v1.31.4
sudo kubeadm upgrade apply v1.31.4

sudo systemctl daemon-reload
sudo systemctl restart kubelet

sudo kubectl uncordon node01
```

sudo kubectl cordon node01

## Backup and Recovery Methodologies
Backup Candidates
- Resource Configuration
    - Declarative
    - k get all --all-namespaces -o yaml > all-deploy-services.yaml
    - velero
- ETCD Cluster
    - state of cluster
    - nodes
    - secrets
    - configmap
    - etcd.services
```    
### Backup
ETCDCTL_API=3 etcdctl snapshot save snapshot.db
ETCDCTL_API=3 etcdctl snapshot status snapshot.db

service kube-apiserver stop

ETCDCTL_API=3 etcdctl snapshot restore snapshot.db --data-dir /var/lib/etcd-from-backup
```

```etcd.services
--data-dir=/var/lib/etcd-from-backup


  volumes:
  - hostPath:
      path: /var/lib/etcd-from-backup
      type: DirectoryOrCreate
    name: etcd-data
```

```
sudo systemctl daemon-reload
sudo service kube-apiserver start
```

- Persistence Volume

```backup
ETCDCTL_API=3 etcdctl snapshot save /opt/snapshot-pre-boot.db \
    --cacert="/etc/kubernetes/pki/etcd/ca.crt" \
    --cert="/etc/kubernetes/pki/etcd/server.crt" \
    --endpoints=https://[127.0.0.1]:2379 \
    --key="/etc/kubernetes/pki/etcd/server.key"

ls /opt/snapshot-pre-boot.db
```

```restore
ETCDCTL_API=3 etcdctl snapshot restore --data-dir /var/lib/etcd-from-backup /opt/snapshot-pre-boot.db \
    --cacert="/etc/kubernetes/pki/etcd/ca.crt" \
    --cert="/etc/kubernetes/pki/etcd/server.crt" \
    --endpoints=https://[127.0.0.1]:2379 \
    --key="/etc/kubernetes/pki/etcd/server.key"


ls /var/lib/etcd-from-backup

crictl ps | grep -i etcd

kubectl get pods -n kube-system | grep -i etcd
```

## Practice Test Backup and Restore Methods 2
```

```