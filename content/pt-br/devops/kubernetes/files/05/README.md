# DAY 05

- kubeadm: É uma ferramenta para criar e gerenciar um cluster Kubernetes em vários nós. Ele automatiza muitas das tarefas de configuração do cluster, incluindo a instalação do control plane e dos nodes. É altamente configurável e pode ser usado para criar clusters personalizados.

- Kubespray: É uma ferramenta que usa o Ansible para implantar e gerenciar um cluster Kubernetes em vários nós. Ele oferece muitas opções para personalizar a instalação do cluster, incluindo a escolha do provedor de rede, o número de réplicas do control plane, o tipo de armazenamento e muito mais. É uma boa opção para implantar um cluster em vários ambientes, incluindo nuvens públicas e privadas.

- Cloud Providers: Muitos provedores de nuvem, como AWS, Google Cloud Platform e Microsoft Azure, oferecem opções para implantar um cluster Kubernetes em sua infraestrutura. Eles geralmente fornecem modelos predefinidos que podem ser usados para implantar um cluster com apenas alguns cliques. Alguns provedores de nuvem também oferecem serviços gerenciados de Kubernetes que lidam com toda a configuração e gerenciamento do cluster.

- Kubernetes Gerenciados: São serviços gerenciados oferecidos por alguns provedores de nuvem, como Amazon EKS, o GKE do Google Cloud e o AKS, da Azure. Eles oferecem um cluster Kubernetes gerenciado onde você só precisa se preocupar em implantar e gerenciar seus aplicativos. Esses serviços lidam com a configuração, atualização e manutenção do cluster para você. Nesse caso, você não tem que gerenciar o control plane do cluster, pois ele é gerenciado pelo provedor de nuvem.

- Kops: É uma ferramenta para implantar e gerenciar clusters Kubernetes na nuvem. Ele foi projetado especificamente para implantação em nuvens públicas como AWS, GCP e Azure. Kops permite criar, atualizar e gerenciar clusters Kubernetes na nuvem. Algumas das principais vantagens do uso do Kops são a personalização, escalabilidade e segurança. No entanto, o uso do Kops pode ser mais complexo do que outras opções de instalação do Kubernetes, especialmente se você não estiver familiarizado com a nuvem em que está implantando.

- Minikube e kind: São ferramentas que permitem criar um cluster Kubernetes localmente, em um único nó. São úteis para testar e aprender sobre o Kubernetes, pois você pode criar um cluster em poucos minutos e começar a implantar aplicativos imediatamente. Elas também são úteis para pessoas desenvolvedoras que precisam testar suas aplicações em um ambiente Kubernetes sem precisar configurar um cluster em um ambiente de produção.

## kubeadm Commands
Agora que você já sabe o que é o Kubernetes e quais são as suas principais funcionalidades, vamos começar a instalar o Kubernetes em nosso cluster. Nesse momento iremos ver como realizar a criação de um cluster Kubernetes utilizando o kubeadm, porém no decorrer da nossa jornada iremos ver outras formas de instalar o Kubernetes.

Como falado, o kubeadm é uma ferramenta para criar e gerenciar um cluster Kubernetes em vários nós. Ele automatiza muitas das tarefas de configuração do cluster, incluindo a instalação do control plane e dos nodes.

Primeira coisa, para que possamos seguir em frente, temos que entender quais são os pré-requisitos para a instalação do Kubernetes. Para isso, você pode consultar a documentação oficial do Kubernetes, mas vou listar aqui os principais pré-requisitos:

Linux

2 GB ou mais de RAM por máquina (menos de 2 GB não é recomendado)

2 CPUs ou mais

Conexão de rede entre todas os nodes no cluster (pode ser via rede pública ou privada)

Algumas portas precisam estar abertas para que o cluster funcione corretamente, as principais:

- [X] Porta 6443: É a porta padrão usada pelo Kubernetes API Server para se comunicar com os componentes do cluster. É a porta principal usada para gerenciar o cluster e deve estar sempre aberta.

- [X] Portas 10250-10255: Essas portas são usadas pelo kubelet para se comunicar com o control plane do Kubernetes. A porta 10250 é usada para comunicação de leitura/gravação e a porta 10255 é usada apenas para comunicação de leitura.

- [X] Porta 30000-32767: Essas portas são usadas para serviços NodePort que precisam ser acessíveis fora do cluster. O Kubernetes aloca uma porta aleatória dentro desse intervalo para cada serviço NodePort e redireciona o tráfego para o pod correspondente.

- [X] Porta 2379-2380: Essas portas são usadas pelo etcd, o banco de dados de chave-valor distribuído usado pelo control plane do Kubernetes. A porta 2379 é usada para comunicação de leitura/gravação e a porta 2380 é usada apenas para comunicação de eleição.
```

K8S_CONTROL_PLANE=$(aws ec2 create-security-group \
    --group-name "k8s-control-plane" \
    --description "Kubernetes Control Plane" \
    --vpc-id vpc-02361954735b56d74 | jq -r .GroupId)
echo $K8S_CONTROL_PLANE

K8S_WORKER=$(aws ec2 create-security-group \
    --group-name "k8s-worker" \
    --description "Kubernetes Worker" \
    --vpc-id vpc-02361954735b56d74)
echo $K8S_WORKER

aws ec2 authorize-security-group-ingress \
    --group-id $K8S_CONTROL_PLANE \
    --protocol tcp \
    --port 6443 \
    --cidr "172.31.0.0/16"

aws ec2 authorize-security-group-ingress \
    --group-id $K8S_CONTROL_PLANE \
    --ip-permissions IpProtocol=tcp,FromPort=2379,ToPort=2380,IpRanges="[{CidrIp=172.31.0.0/16}]"

aws ec2 authorize-security-group-ingress \
    --group-id $K8S_CONTROL_PLANE \
    --ip-permissions IpProtocol=tcp,FromPort=10250,ToPort=10255,IpRanges="[{CidrIp=172.31.0.0/16}]"

## Liberando por source-group
aws ec2 authorize-security-group-ingress \
    --group-id sg-1234567890abcdef0 \
    --protocol tcp \
    --port 80 \
    --source-group sg-1a2b3c4d    

aws ec2 describe-security-group-rules \
    --security-group-rule-ids <ID>

aws ec2 describe-security-groups --group-ids $K8S_CONTROL_PLANE
aws ec2 describe-security-groups --group-ids $K8S_WORKER


ubuntu@ec2-3-82-204-255.compute-1.amazonaws.com
sudo hostnamectl hostname k8s-01
sudo swapoff -a
## cat /etc/fstab (se tiver na listagem o swap significa que o mesmo esta habilitado)
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

sudo sysctl --system

sudo apt update && sudo apt install -y apt-transport-https curl
curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo apt-key add -
echo "deb https://apt.kubernetes.io/ kubernetes-xenial main" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt update -y
sudo apt install -y kubelet kubeadm kubectl
sudo apt-mark hold kubelet kubeadm kubectl

sudo apt update && sudo apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin docker-compose

sudo containerd config default | sudo tee /etc/containerd/config.toml
sudo vim /etc/containerd/config.toml
---
SystemdCgroup = false to SystemdCgroup = true
---
sudo systemctl restart containerd
sudo systemctl enable containerd
sudo systemctl enable --now kubelet
sudo systemctl status containerd

# Caso precise deletar use este comando a seguir: sudo kubeadm reset
sudo kubeadm init --pod-network-cidr=10.10.0.0/16 --apiserver-advertise-address=172.31.37.18

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl config view

sudo kubeadm join 172.31.37.18:6443 --token pg7gcg.3k9cu4jewgt1839g \
	--discovery-token-ca-cert-hash sha256:c817d1f578b7783bf6e6f43e58d07df7975970d5da302b59cad93bb2ba17270d 

C.N.I (Container Network Interface): é uma especificação e um conjunto de bibliotecas para escrever plugins para configurar interfaces de rede em containers de softwares. Foi proposto pela CoreOS como um padrão comum para permitir a interoperabilidade entre diferentes plataformas de containers (como Kubernetes, Mesos, CloudFoundry e etc) e redes de containers (como Weave, Calico, Cilium e etc)


kubectl apply -f https://github.com/weaveworks/weave/releases/download/v2.8.1/weave-daemonset-k8s.yaml
```


echo "{\"GroupId\": \"sg-903004f8\"}"