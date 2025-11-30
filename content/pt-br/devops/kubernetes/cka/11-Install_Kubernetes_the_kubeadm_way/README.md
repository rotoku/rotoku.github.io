# Install Kubernetes the kubeadm way

## rational for installation
|Steps|Description|Node Master|Node Worker|
|-----|-----|-----|-----|
|1|Install containerd|X|X|
|2|Install kubeadm|X|X|
|3|Initialize|X||
|4|Pod Network|X|X|
|5|Join Node||X|

## Clone Project
```
git clone https://github.com/kodekloudhub/certified-kubernetes-administrator-course
cd certified-kubernetes-administrator-course/kubeadm-clusters/virtualbox
```

## [Install VirtualBox](https://www.virtualbox.org/wiki/Downloads?)

## [Install Vagrant](https://developer.hashicorp.com/vagrant/docs/installation)

```
vagrant status
vagrant destroy -f
vagrant up
vagrant status
vagrant ssh <node>
```

## Deployment with Kubeadm
```
vagrant@controlplane:~$ ip add
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536 qdisc noqueue state UNKNOWN group default qlen 1000
    link/loopback 00:00:00:00:00:00 brd 00:00:00:00:00:00
    inet 127.0.0.1/8 scope host lo
       valid_lft forever preferred_lft forever
    inet6 ::1/128 scope host 
       valid_lft forever preferred_lft forever
2: enp0s3: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 02:a7:b1:fd:e7:e2 brd ff:ff:ff:ff:ff:ff
    inet 10.0.2.15/24 metric 100 brd 10.0.2.255 scope global dynamic enp0s3
       valid_lft 84517sec preferred_lft 84517sec
    inet6 fd00::a7:b1ff:fefd:e7e2/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 86374sec preferred_lft 14374sec
    inet6 fe80::a7:b1ff:fefd:e7e2/64 scope link 
       valid_lft forever preferred_lft forever
3: enp0s8: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500 qdisc fq_codel state UP group default qlen 1000
    link/ether 08:00:27:14:ca:45 brd ff:ff:ff:ff:ff:ff
    inet 192.168.0.30/24 metric 100 brd 192.168.0.255 scope global dynamic enp0s8
       valid_lft 3519sec preferred_lft 3519sec
    inet6 2804:14d:7841:91f3:a00:27ff:fe14:ca45/64 scope global dynamic mngtmpaddr noprefixroute 
       valid_lft 3600sec preferred_lft 3600sec
    inet6 fe80::a00:27ff:fe14:ca45/64 scope link 
```

```
enp0s8:
#kodekloud          -   meupc
192.168.56.11/24    -   192.168.0.30/24
192.168.56.21/24    -   192.168.0.31/24
192.168.56.22/24    -   192.168.0.32/24
```

```
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gpg
curl -fsSL https://pkgs.k8s.io/core:/stable:/v1.31/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg

echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v1.31/deb/ /' | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update -y
sudo apt-get install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

kubeadm version

sudo apt-get update -y
sudo apt-get install -y containerd

# check if the system using systemd OR cgroupfs
ps -p 1


ls -lrth /etc/containerd/config.toml
# se o arquivo não existe devemos cria o mesmo
sudo mkdir -p /etc/containerd/

containerd config default | sed 's/SystemdCgroup = false/SystemdCgroup = true/' | sudo tee /etc/containerd/config.toml

cat /etc/containerd/config.toml | grep -i "SystemdCgroup" -B 50

sudo systemctl restart containerd


# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.ipv4.ip_forward = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

sudo kubeadm init --apiserver-advertise-address 192.168.0.30 --pod-network-cidr "10.244.0.0/16" --upload-certs

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.0.30:6443 --token z76jgn.muts3dy3hllb5cuf \
        --discovery-token-ca-cert-hash sha256:cb35577929f0fe58b8e5e279b8d5738ecff02e4983703f71968b5d2f10769e83 
------------------------------------------------------------------------------------------
sudo kubeadm init --apiserver-advertise-address 192.168.0.20 --pod-network-cidr "10.244.0.0/16" --upload-certs

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:
  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config

Alternatively, if you are the root user, you can run:

  export KUBECONFIG=/etc/kubernetes/admin.conf

You should now deploy a pod network to the cluster.
Run "kubectl apply -f [podnetwork].yaml" with one of the options listed at:
  https://kubernetes.io/docs/concepts/cluster-administration/addons/

Then you can join any number of worker nodes by running the following on each as root:

kubeadm join 192.168.0.20:6443 --token ywlqhr.fplizkhmlenyrwr2 \
        --discovery-token-ca-cert-hash sha256:09f2629d4e910ac97b447f8d444fb0580793bb60a558958a000cf2da6a98ed6d
```

kubectl apply -f https://reweave.azurewebsites.net/k8s/v1.31/net.yaml

```
sudo kubeadm reset cleanup-node
```

```
sudo apt-get install -y kubelet=1.31.0-1.1 kubeadm=1.31.0-1.1 kubectl=1.31.0-1.1
sudo apt-mark hold kubelet kubeadm kubectl

kubelet --version
kubeadm version
kubectl version

sudo kubeadm init \
    --apiserver-advertise-address 192.12.209.3 \
    --apiserver-cert-extra-sans controlplane \
    --pod-network-cidr "10.244.0.0/16"


To install a network plugin, we will go with Flannel as the default choice. For inter-host communication, we will utilize the eth0 interface.


Open the kube-flannel.yml file using a text editor.

Locate the args section within the kube-flannel container definition. It should look like this:

  args:
  - --ip-masq
  - --kube-subnet-mgr
Add the additional argument - --iface=eth0 to the existing list of arguments.

```


```
vagrant halt
vagrant destroy
```
------------------------------------------------------------------------------------------------------------------------------------------------
## Uninstall
```
k get all -A
k get nodes

# Desative o cluster no nó controlador
sudo kubeadm reset

# removendo os arquivos de configurações
sudo rm -rf /etc/kubernetes /var/lib/etcd /var/lib/kubelet /var/lib/dockershim /var/run/kubernetes /etc/cni /opt/cni

# Desintale pacotes do kubernetes
sudo apt-mark unhold kubelet kubeadm
sudo apt purge -y kubeadm kubelet kubernetes-cni
sudo apt autoremove -y

# Removendo o containerd
sudo apt purge -y containerd
sudo apt autoremove -y
sudo rm -rf /var/lib/containerd

sudo reboot
```