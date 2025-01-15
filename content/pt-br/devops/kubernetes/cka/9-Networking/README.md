# Networking

- Switching and Routing
    - Switching
        - conect 2 or more computers in the same networking
    - Routing
        - conect 2 or more networking
    - Default Gateway
        - dor to internet
- DNS
    - DNS Configurations on Linux
    - CoreDNS Introduction
- Network Namespaces
- Docker Networking

> Flannel do not support network policies

## Linux Networking Basics
```
ip link
ip addr
ip addr add 192.168.1.10/24 dev eth0
sudo ip link set dev eth0 up
sudo ip r add default via 172.16.238.1

ip route
ip route add 192.168.1.0/24 via 192.168.2.1

### Permitir encaminhamento de pacote via interface de redes distintas
cat /proc/sys/net/ipv4/ip_forward
0: disable
1: enable

cat /etc/sysctl.conf
net.ipv4.ip_forward=1

sudo ip addr add 172.16.238.15/24 dev eth0
ip addr

sudo ip addr add 172.16.238.16/24 dev eth0
ip addr

sudo ip addr add 172.16.239.15/24 dev eth0
ip addr

sudo ip addr add 172.16.239.16/24 dev eth0
ip addr

sudo ip addr add 172.16.239.10/24 dev eth0
ip addr

ip route
sudo ip route add 172.16.239.0/24 via 172.16.238.10

ip route
sudo ip route add 172.16.238.0/24 via 172.16.239.10

ping -c 4 app01
ping -c 4 app02
ping -c 4 app03
ping -c 4 app04
```


```/etc/resolv.conf
nameserver 192.168.0.100
```

```
ip netns add red
ip netns add blue
ip netns

ip link

ip netns exec red ip link
ip -n red link

arp
ip netns exec red arp

iptables -t nat -A POSTROUTING -s 192.168.15.0/24-j MASQUERADE

iptables -t nat -A PREROUTING --dport 80 --to-destination 192.168.15.2:80 -j DNAT

iptables -nvL -t nat

netstat -plnt

route
```

## Docker Network
- None
- host
- bridge (default)

## CNI - Container Network Interface
- Cilium
- Calico
- Weave works
- Flannel

```net-script.sh
## create veth par
ip link add ...

## attach veth pair
ip link set ...
ip link set ...

## assign ip address
ip -n <namespace> addr add ...
ip -n <namespace> route add ...

## bring up interface
ip -n <namespace> link set ...
```

## CNI Weave
```
## Deploy
kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
```

## IPAM
- weave: 10.32.0.0/12

## CoreDNS

``` 
cat /etc/coredns/Corefile

k get cm coredns n-system

k get svc kube-dns -n kube-system

curl http://kube-dns.kube-system.svc.cluster.local
``` 


## Turkey Solutions
- OpenShift
- Cloud Foundry Container Runtime
- VMware Cloud PKS
- Vagrant
- KOPS

## Hosted Solutions
- EKS - Elastic Kubernetes Service
- AKS - Azure Kubernetes Service
- GKE - Google Kubernetes Engineer
- OpenShift Online

## Configure High Availability

|-----------------------------------|
|Master1                            |
|API Server (Active|Active -> LB)   |
|                                   |
|ETCD (External Nodes)              |
|                                   |
|Controller Manager (Active|Standby)|
|Scheduler (Active|Standby)         |
-------------------------------------

## ETCD High Availability
```
wget -q --https-only \
    "https://github.com/coreos/etcd/releases/download/v3.3.9/etcd-v3.3.9-linux-amd64.tar.gz"

tar -xvf etcd-v3.3.9-linux-amd64.tar.gz

mv etcd-v3.3.9-linux-amd64/etcd* /usr/local/bin/

mkdir -p /etc/etcd /var/lib/etcd

cp ca.pem kubernetes-key.pem kubernetes.pem /etc/etcd/
```

```etcd.service
ExecStart=/usr/local/bin/etcd \
    --name ${ETCD_NAME} \
    --cert-file=/etc/etcd/kubernetes.pem \
    --key-file=/etc/etcd/kubernetes-key.pem \
    --peer-cert-file=/etc/etcd/kubernetes.pem \
    --peer-key-file=/etc/etcd/kubernetes-key.pem \
    --trusted-ca-file=/etc/etcd/ca.pem \
    --peer-trusted-ca-file=/etc/etcd/ca.pem \
    --peer-client-cert-auth \
    --client-cert-auth \
    --initial-advertise-peer-urls https://${INTERNAL_IP}:2380 \
    --listen-peer-urls https://${INTERNAL_IP}:2380 \
    --listen-client-urls https://${INTERNAL_IP}:2379,https://127.0.0.1:2379 \
    --advertise-client-urls https://${INTERNAL_IP}:2379 \
    --initial-cluster-token etcd-cluster-0 \
    --initial-cluster peer-1=https://${PEER1_IP}:2380,peer-2=https://${PEER2_IP}:2380 \
    --initial-cluster-state new \
    --data-dir=/var/lib/etcd
```

> Better way to have 3 etc, odd numbers are better