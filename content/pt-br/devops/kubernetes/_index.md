---
title: "Kubernetes"
linkTitle: "Kubernetes"
date: 2023-10-07
weight: 10
---

---

---

---

# Kubernetes

## Kinds

| kind                  |       version        |
| :-------------------- | :------------------: |
| Pod                   |          v1          |
| Service               |          v1          |
| ReplicaSet            |       apps/v1        |
| Deployment            |       apps/v1        |
| Namespace             |          v1          |
| PersistentVolume      |          v1          |
| PersistentVolumeClaim |          v1          |
| StorageClass          |  storage.k8s.io/v1   |
| StatefullSet          |       apps/v1        |
| Secret                |          v1          |
| ConfigMap             |          v1          |
| Ingress               | networking.k8s.io/v1 |

## Entendendo o que são containers e o kubernetes

### o que é container?

Containers são unidades executáveis de software em que o código do aplicativo é empacotado com suas respectivas bibliotecas e dependências, usando métodos comuns para executá-los em qualquer lugar, seja em um computador desktop, na estrutura de TI tradicional ou na cloud.
É um isolamento de recursos.
o que pode ser recursos:

- cpu
- memória
- disco

- Namespaces: namespaces disponibilizam um mecanismo para isolar grupos de recursos dentro de um único cluster.
- chroot: O comando chroot do sistema operacional Unix é uma operação que muda o diretório root do processo corrente e de seus processos filhos. Um programa que é re-rooted para um outro diretório não pode acessar arquivos fora daquele diretório, e o diretório é chamado de "prisão chroot"
- Containers:
  - docker
  - podman
  - CRI-O

### o que é container engine?

- não aceita mais docker como container engine, por que havia uma gambi chamado Dockershim que foi removido do Kubernetes na release v1.24
- é o cara responsável pela integração com os recursos
- podem executar várias instâncias isoladas, conhecidas como contêineres, no mesmo kernel do sistema operacional . Os contêineres executam a virtualização no nível do sistema operacional e fornecem um ambiente controlável e facilmente gerenciável para a execução de aplicativos e dependências.

### o que é um container runtime?

- conversa com o kernel
- responsável por executar o container
- cgroups/containers
- Tipos:
  1. alto nível: fala com o kernel (containerd, o CRI-O e o Podman.)
  2. baixo nível: fala com as aplicações (runc, o crun e o runsc.)

### o que é a OCI?

A Open Container Initiative é um projeto da Linux Foundation, iniciado em junho de 2015 por Docker, CoreOS e os mantenedores do appc para projetar padrões abertos para virtualização em nível de sistema operacional.

### O que é o kubernetes?

Como Kubernetes é uma palavra difícil de se pronunciar - e de se escrever - a comunidade simplesmente o apelidou de k8s, seguindo o padrão i18n (a letra "k" seguida por oito letras e o "s" no final), pronunciando-se simplesmente "kates".

- em 2014 a google criou o projeto BORG, desenvolvido em go
  É um orquestrador de Containers. - subir mais containers, baixar - outros exemplos de orquestradores: nomad, ecs, mesos, swarm

### O que são os workers e o control plane do kubernetes?

![Arquitetura](../../imgs/arquitetura_k8s.jpeg)

### Quais os componentes do control plane do kubernetes?

![alt text](../../imgs/componentes_control_plane.jpeg)

### Quais os componentes dos workers do kubernetes?

![alt text](../../imgs/componentes_workers.jpeg)

### Todos os componentes

- API Server: É um dos principais componentes do k8s. Este componente fornece uma API que utiliza JSON sobre HTTP para comunicação, onde para isto é utilizado principalmente o utilitário kubectl, por parte dos administradores, para a comunicação com os demais nós, como mostrado no gráfico. Estas comunicações entre componentes são estabelecidas através de requisições REST;

- etcd: O etcd é um datastore chave-valor distribuído que o k8s utiliza para armazenar as especificações, status e configurações do cluster. Todos os dados armazenados dentro do etcd são manipulados apenas através da API. Por questões de segurança, o etcd é por padrão executado apenas em nós classificados como control plane no cluster k8s, mas também podem ser executados em clusters externos, específicos para o etcd, por exemplo;

- Scheduler: O scheduler é responsável por selecionar o nó que irá hospedar um determinado pod (a menor unidade de um cluster k8s - não se preocupe sobre isso por enquanto, nós falaremos mais sobre isso mais tarde) para ser executado. Esta seleção é feita baseando-se na quantidade de recursos disponíveis em cada nó, como também no estado de cada um dos nós do cluster, garantindo assim que os recursos sejam bem distribuídos. Além disso, a seleção dos nós, na qual um ou mais pods serão executados, também pode levar em consideração políticas definidas pelo usuário, tais como afinidade, localização dos dados a serem lidos pelas aplicações, etc;

- Controller Manager: É o controller manager quem garante que o cluster esteja no último estado definido no etcd. Por exemplo: se no etcd um deploy está configurado para possuir dez réplicas de um pod, é o controller manager quem irá verificar se o estado atual do cluster corresponde a este estado e, em caso negativo, procurará conciliar ambos;

- Kubelet: O kubelet pode ser visto como o agente do k8s que é executado nos nós workers. Em cada nó worker deverá existir um agente Kubelet em execução. O Kubelet é responsável por de fato gerenciar os pods, que foram direcionados pelo controller do cluster, dentro dos nós, de forma que para isto o Kubelet pode iniciar, parar e manter os contêineres e os pods em funcionamento de acordo com o instruído pelo controlador do cluster;

- Kube-proxy: Age como um proxy e um load balancer. Este componente é responsável por efetuar roteamento de requisições para os pods corretos, como também por cuidar da parte de rede do nó;

- Pod: É o menor objeto do k8s. Como dito anteriormente, o k8s não trabalha com os contêineres diretamente, mas organiza-os dentro de pods, que são abstrações que dividem os mesmos recursos, como endereços, volumes, ciclos de CPU e memória. Um pod pode possuir vários contêineres;

- Deployment: É um dos principais controllers utilizados. O Deployment, em conjunto com o ReplicaSet, garante que determinado número de réplicas de um pod esteja em execução nos nós workers do cluster. Além disso, o Deployment também é responsável por gerenciar o ciclo de vida das aplicações, onde características associadas a aplicação, tais como imagem, porta, volumes e variáveis de ambiente, podem ser especificados em arquivos do tipo yaml ou json para posteriormente serem passados como parâmetro para o kubectl executar o deployment. Esta ação pode ser executada tanto para criação quanto para atualização e remoção do deployment;

- ReplicaSets: É um objeto responsável por garantir a quantidade de pods em execução no nó;

- Services: É uma forma de você expor a comunicação através de um ClusterIP, NodePort ou LoadBalancer para distribuir as requisições entre os diversos Pods daquele Deployment. Funciona como um balanceador de carga.

### Quais as portas TCP e UDP dos componentes do kubernetes?

#### Control Plane

- kube-api server: 6443 tcp
- etcd: 2379,2380 tcp
- kubelet: 10250 tcp
- kube-scheduler: 10251 tcp
- kube-controller: 10252 tcp

#### WORKERS

- kubelet: 10250 tcp
- nodeport: 30000-32767 tcp

- weave net: 6783-6784 tcp/udp

### Introdução a pods, replica sets, deployments e service

- menor unidade de gerenciamento do k8s é o POD
- um pod pode ter mais de um container
  ![alt text](../../imgs/pods_replicasets_deployments_service.jpeg)

### Entendendo e instalando o kubectl

```
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl
kubectl version --client --short
```

#### docker

```
curl -fsSL https://get.docker.com | bash
```

#### [kind](https://kind.sigs.k8s.io/docs/user/quick-start/)

```
# For AMD64 / x86_64
[ $(uname -m) = x86_64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.25.0/kind-linux-amd64
# For ARM64
[ $(uname -m) = aarch64 ] && curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.25.0/kind-linux-arm64
chmod +x ./kind
sudo mv ./kind /usr/local/bin/kind
```

```
kind create cluster
kubectl get nodes
kind delete cluster --name $(kind get clusters)
```

criando cluster com 3 nodes

```cluster.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
```

```
kind create cluster --config /media/rkumabe/DATA/git/rotoku.github.io/content/pt-br/devops/kubernetes/files/01/meu-primeiro-cluster.yaml --name giropops
```

### Primeiros passos no kubernetes com o kubectl

```
kubectl get nodes
kubectl get pods
kubectl get deployments
kubectl get namespaces
kubectl get service
kubectl get replicaset
kubectl get pods -n kube-system
kubectl get pods -n kube-system -o wide
## Pegar pods de todos namespaces
kubectl get pods -A
kubectl run --image nginx --port=80 giropops
kubectl get pods
kubectl exec -it giropops -- bash
kubectl delete pods giropops
kubectl get pods
kubectl run --image nginx --port=80 nginx --dry-run=client -o yaml > nginx.yaml
kubectl apply -f /media/rkumabe/DATA/git/rotoku.github.io/content/pt-br/devops/kubernetes/files/01/meu-primeiro-pod.yaml
```

### Criando um cluster Kubernetes

### Criando o cluster em sua máquina local

Vamos mostrar algumas opções, caso você queira começar a brincar com o Kubernetes utilizando somente a sua máquina local, o seu desktop.

Lembre-se, você não é obrigado a testar/utilizar todas as opções abaixo, mas seria muito bom caso você testasse. :D

#### Minikube

##### Requisitos básicos

É importante frisar que o Minikube deve ser instalado localmente, e não em um _cloud provider_. Por isso, as especificações de _hardware_ a seguir são referentes à máquina local.

- Processamento: 1 core;
- Memória: 2 GB;
- HD: 20 GB.

##### Instalação do Minikube no GNU/Linux

Antes de mais nada, verifique se a sua máquina suporta virtualização. No GNU/Linux, isto pode ser realizado com o seguinte comando:

```
grep -E --color 'vmx|svm' /proc/cpuinfo
```

&nbsp;
Caso a saída do comando não seja vazia, o resultado é positivo.

Há a possibilidade de não utilizar um _hypervisor_ para a instalação do Minikube, executando-o ao invés disso sobre o próprio host. Iremos utilizar o Oracle VirtualBox como _hypervisor_, que pode ser encontrado [aqui](https://www.virtualbox.org).

Efetue o download e a instalação do `Minikube` utilizando os seguintes comandos.

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64

chmod +x ./minikube

sudo mv ./minikube /usr/local/bin/minikube

minikube version
```

&nbsp;

##### Instalação do Minikube no MacOS

No MacOS, o comando para verificar se o processador suporta virtualização é:

```
sysctl -a | grep -E --color 'machdep.cpu.features|VMX'
```

&nbsp;
Se você visualizar `VMX` na saída, o resultado é positivo.

Efetue a instalação do Minikube com um dos dois métodos a seguir, podendo optar-se pelo Homebrew ou pelo método tradicional.

```
sudo brew install minikube

minikube version
```

&nbsp;
Ou:

```
curl -Lo minikube https://storage.googleapis.com/minikube/releases/latest/minikube-darwin-amd64

chmod +x ./minikube

sudo mv ./minikube /usr/local/bin/minikube

minikube version
```

&nbsp;

##### Instalação do Minikube no Microsoft Windows

No Microsoft Windows, você deve executar o comando `systeminfo` no prompt de comando ou no terminal. Caso o retorno deste comando seja semelhante com o descrito a seguir, então a virtualização é suportada.

```
Hyper-V Requirements:     VM Monitor Mode Extensions: Yes
                          Virtualization Enabled In Firmware: Yes
                          Second Level Address Translation: Yes
                          Data Execution Prevention Available: Yes
```

&nbsp;
Caso a linha a seguir também esteja presente, não é necessária a instalação de um _hypervisor_ como o Oracle VirtualBox:

```
Hyper-V Requirements:     A hypervisor has been detected. Features required for Hyper-V will not be displayed.:     A hypervisor has been detected. Features required for Hyper-V will not be displayed.
```

&nbsp;
Faça o download e a instalação de um _hypervisor_ (preferencialmente o [Oracle VirtualBox](https://www.virtualbox.org)), caso no passo anterior não tenha sido acusada a presença de um. Finalmente, efetue o download do instalador do Minikube [aqui](https://github.com/kubernetes/minikube/releases/latest) e execute-o.

##### Iniciando, parando e excluindo o Minikube

Quando operando em conjunto com um _hypervisor_, o Minikube cria uma máquina virtual, onde dentro dela estarão todos os componentes do k8s para execução.

É possível selecionar qual _hypervisor_ iremos utilizar por padrão, através no comando abaixo:

```
minikube config set driver <SEU_HYPERVISOR>
```

&nbsp;
Você deve substituir <SEU_HYPERVISOR> pelo seu hypervisor, por exemplo o KVM2, QEMU, Virtualbox ou o Hyperkit.

Caso não queria configurar um hypervisor padrão, você pode digitar o comando `minikube start --driver=hyperkit` toda vez que criar um novo ambiente.

##### Certo, e como eu sei que está tudo funcionando como deveria?

Uma vez iniciado, você deve ter uma saída na tela similar à seguinte:

```
minikube start --driver=virtualbox --nodes=3

😄  minikube v1.26.0 on Debian bookworm/sid
✨  Using the qemu2 (experimental) driver based on user configuration
👍  Starting control plane node minikube in cluster minikube
🔥  Creating qemu2 VM (CPUs=2, Memory=6000MB, Disk=20000MB) ...
🐳  Preparing Kubernetes v1.24.1 on Docker 20.10.16 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: default-storageclass, storage-provisioner
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

```

Você pode então listar os nós que fazem parte do seu _cluster_ k8s com o seguinte comando:

```
kubectl get nodes
```

&nbsp;
A saída será similar ao conteúdo a seguir:

```
NAME       STATUS   ROLES           AGE   VERSION
minikube   Ready    control-plane   20s   v1.25.3
```

&nbsp;
Para criar um cluster com mais de um nó, você pode utilizar o comando abaixo, apenas modificando os valores para o desejado:

```
minikube start --nodes 2 -p multinode-cluster

😄  minikube v1.26.0 on Debian bookworm/sid
✨  Automatically selected the docker driver. Other choices: kvm2, virtualbox, ssh, none, qemu2 (experimental)
📌  Using Docker driver with root privileges
👍  Starting control plane node minikube in cluster minikube
🚜  Pulling base image ...
💾  Downloading Kubernetes v1.24.1 preload ...
    > preloaded-images-k8s-v18-v1...: 405.83 MiB / 405.83 MiB  100.00% 66.78 Mi
    > gcr.io/k8s-minikube/kicbase: 385.99 MiB / 386.00 MiB  100.00% 23.63 MiB p
    > gcr.io/k8s-minikube/kicbase: 0 B [_________________________] ?% ? p/s 11s
🔥  Creating docker container (CPUs=2, Memory=8000MB) ...
🐳  Preparing Kubernetes v1.24.1 on Docker 20.10.17 ...
    ▪ Generating certificates and keys ...
    ▪ Booting up control plane ...
    ▪ Configuring RBAC rules ...
🔗  Configuring CNI (Container Networking Interface) ...
🔎  Verifying Kubernetes components...
    ▪ Using image gcr.io/k8s-minikube/storage-provisioner:v5
🌟  Enabled addons: storage-provisioner, default-storageclass

👍  Starting worker node minikube-m02 in cluster minikube
🚜  Pulling base image ...
🔥  Creating docker container (CPUs=2, Memory=8000MB) ...
🌐  Found network options:
    ▪ NO_PROXY=192.168.11.11
🐳  Preparing Kubernetes v1.24.1 on Docker 20.10.17 ...
    ▪ env NO_PROXY=192.168.11.11
🔎  Verifying Kubernetes components...
🏄  Done! kubectl is now configured to use "minikube" cluster and "default" namespace by default

```

&nbsp;
Para visualizar os nós do seu novo cluster Kubernetes, digite:

```
kubectl get nodes
```

&nbsp;
Inicialmente, a intenção do Minikube é executar o k8s em apenas um nó, porém a partir da versão 1.10.1 é possível usar a função de multi-node.

Caso os comandos anteriores tenham sido executados sem erro, a instalação do Minikube terá sido realizada com sucesso.

##### Ver detalhes sobre o cluster

```
minikube status
```

&nbsp;

##### Descobrindo o endereço do Minikube

Como dito anteriormente, o Minikube irá criar uma máquina virtual, assim como o ambiente para a execução do k8s localmente. Ele também irá configurar o `kubectl` para comunicar-se com o Minikube. Para saber qual é o endereço IP dessa máquina virtual, pode-se executar:

```
minikube ip
```

&nbsp;
O endereço apresentado é que deve ser utilizado para comunicação com o k8s.

##### Acessando a máquina do Minikube via SSH

Para acessar a máquina virtual criada pelo Minikube, pode-se executar:

```
minikube ssh
```

&nbsp;

##### Dashboard do Minikube

O Minikube vem com um _dashboard_ _web_ interessante para que o usuário iniciante observe como funcionam os _workloads_ sobre o k8s. Para habilitá-lo, o usuário pode digitar:

```
minikube dashboard
```

&nbsp;

##### Logs do Minikube

Os _logs_ do Minikube podem ser acessados através do seguinte comando.

```
minikube logs
```

&nbsp;

##### Remover o cluster

```
minikube delete
```

&nbsp;
Caso queira remover o cluster e todos os arquivos referente a ele, utilize o parametro _--purge_, conforme abaixo:

```
minikube delete --purge
```

&nbsp;

#### Kind

O Kind (_Kubernetes in Docker_) é outra alternativa para executar o Kubernetes num ambiente local para testes e aprendizado, mas não é recomendado para uso em produção.

##### Instalação no GNU/Linux

Para fazer a instalação no GNU/Linux, execute os seguintes comandos.

```
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-linux-amd64

chmod +x ./kind

sudo mv ./kind /usr/local/bin/kind
```

&nbsp;

##### Instalação no MacOS

Para fazer a instalação no MacOS, execute o seguinte comando.

```
sudo brew install kind
```

&nbsp;
ou

```
curl -Lo ./kind https://kind.sigs.k8s.io/dl/v0.14.0/kind-darwin-amd64
chmod +x ./kind
mv ./kind /usr/bin/kind
```

&nbsp;

##### Instalação no Windows

Para fazer a instalação no Windows, execute os seguintes comandos.

```
curl.exe -Lo kind-windows-amd64.exe https://kind.sigs.k8s.io/dl/v0.14.0/kind-windows-amd64

Move-Item .\kind-windows-amd64.exe c:\kind.exe
```

&nbsp;

###### Instalação no Windows via Chocolatey

Execute o seguinte comando para instalar o Kind no Windows usando o Chocolatey.

```
choco install kind
```

&nbsp;

##### Criando um cluster com o Kind

Após realizar a instalação do Kind, vamos iniciar o nosso cluster.

```
kind create cluster

Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.24.0) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Not sure what to do next? 😅  Check out https://kind.sigs.k8s.io/docs/user/quick-start/

```

&nbsp;
É possível criar mais de um cluster e personalizar o seu nome.

```
kind create cluster --name giropops

Creating cluster "giropops" ...
 ✓ Ensuring node image (kindest/node:v1.24.0) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-giropops"
You can now use your cluster with:

kubectl cluster-info --context kind-giropops

Thanks for using kind! 😊
```

&nbsp;
Para visualizar os seus clusters utilizando o kind, execute o comando a seguir.

```
kind get clusters
```

&nbsp;
Liste os nodes do cluster.

```
kubectl get nodes
```

&nbsp;

##### Criando um cluster com múltiplos nós locais com o Kind

É possível para essa aula incluir múltiplos nós na estrutura do Kind, que foi mencionado anteriormente.

Execute o comando a seguir para selecionar e remover todos os clusters locais criados no Kind.

```
kind delete clusters $(kind get clusters)

Deleted clusters: ["giropops" "kind"]
```

&nbsp;
Crie um arquivo de configuração para definir quantos e o tipo de nós no cluster que você deseja. No exemplo a seguir, será criado o arquivo de configuração `kind-3nodes.yaml` para especificar um cluster com 1 nó control-plane (que executará o control plane) e 2 workers.

```
cat << EOF > $HOME/kind-3nodes.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
  - role: control-plane
  - role: worker
  - role: worker
EOF
```

&nbsp;
Agora vamos criar um cluster chamado `kind-multinodes` utilizando as especificações definidas no arquivo `kind-3nodes.yaml`.

```
kind create cluster --name kind-multinodes --config $HOME/kind-3nodes.yaml

Creating cluster "kind-multinodes" ...
 ✓ Ensuring node image (kindest/node:v1.24.0) 🖼
 ✓ Preparing nodes 📦 📦 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
 ✓ Joining worker nodes 🚜
Set kubectl context to "kind-kind-multinodes"
You can now use your cluster with:

kubectl cluster-info --context kind-kind-multinodes

Have a question, bug, or feature request? Let us know! https://kind.sigs.k8s.io/#community 🙂
```

&nbsp;
Valide a criação do cluster com o comando a seguir.

```
kubectl get nodes
```

&nbsp;
Mais informações sobre o Kind estão disponíveis em: https://kind.sigs.k8s.io

&nbsp;

### Primeiros passos no k8s

&nbsp;

##### Verificando os namespaces e pods

O k8s organiza tudo dentro de _namespaces_. Por meio deles, podem ser realizadas limitações de segurança e de recursos dentro do _cluster_, tais como _pods_, _replication controllers_ e diversos outros. Para visualizar os _namespaces_ disponíveis no _cluster_, digite:

```
kubectl get namespaces
```

&nbsp;
Vamos listar os _pods_ do _namespace_ **kube-system** utilizando o comando a seguir.

```
kubectl get pod -n kube-system
```

&nbsp;
Será que há algum _pod_ escondido em algum _namespace_? É possível listar todos os _pods_ de todos os _namespaces_ com o comando a seguir.

```
kubectl get pods -A
```

&nbsp;
Há a possibilidade ainda, de utilizar o comando com a opção `-o wide`, que disponibiliza maiores informações sobre o recurso, inclusive em qual nó o _pod_ está sendo executado. Exemplo:

```
kubectl get pods -A -o wide
```

&nbsp;

##### Executando nosso primeiro pod no k8s

Iremos iniciar o nosso primeiro _pod_ no k8s. Para isso, executaremos o comando a seguir.

```
kubectl run nginx --image nginx

pod/nginx created
```

&nbsp;
Listando os _pods_ com `kubectl get pods`, obteremos a seguinte saída.

```
NAME    READY   STATUS    RESTARTS   AGE
nginx   1/1     Running   0          66s
```

&nbsp;
Vamos agora remover o nosso _pod_ com o seguinte comando.

```
kubectl delete pod nginx
```

&nbsp;
A saída deve ser algo como:

```
pod "nginx" deleted
```

&nbsp;

##### Executando nosso primeiro pod no k8s

Uma outra forma de criar um pod ou qualquer outro objeto no Kubernetes é através da utilizaçâo de uma arquivo manifesto, que é uma arquivo em formato YAML onde você passa todas as definições do seu objeto. Mas pra frente vamos falar muito mais sobre como construir arquivos manifesto, mas agora eu quero que você conheça a opção `--dry-run` do `kubectl`, pos com ele podemos simular a criação de um resource e ainda ter um manifesto criado automaticamente.

Exemplos:

Para a criação do template de um _pod_:

```
kubectl run meu-nginx --image nginx --dry-run=client -o yaml > pod-template.yaml
```

&nbsp;
Aqui estamos utilizando ainda o parametro '-o', utilizando para modificar a saída para o formato YAML.

Para a criação do _template_ de um _deployment_:

Com o arquivo gerado em mãos, agora você consegue criar um pod utilizando o manifesto que criamos da seguinte forma:

```
kubectl apply -f pod-template.yaml
```

Não se preocupe por enquanto com o parametro 'apply', nós ainda vamos falar com mais detalhes sobre ele, nesse momento o importante é você saber que ele é utilizado para criar novos resources através de arquivos manifestos.

&nbsp;

#### Expondo o pod e criando um Service

Dispositivos fora do _cluster_, por padrão, não conseguem acessar os _pods_ criados, como é comum em outros sistemas de contêineres. Para expor um _pod_, execute o comando a seguir.

```
kubectl expose pod nginx
```

Será apresentada a seguinte mensagem de erro:

```
error: couldn't find port via --port flag or introspection
See 'kubectl expose -h' for help and examples
```

O erro ocorre devido ao fato do k8s não saber qual é a porta de destino do contêiner que deve ser exposta (no caso, a 80/TCP). Para configurá-la, vamos primeiramente remover o nosso _pod_ antigo:

```
kubectl delete -f pod-template.yaml
```

Agora vamos executar novamente o comando para a criação do pod utilizando o parametro 'dry-run', porém agora vamos adicionar o parametro '--port' para dizer qual a porta que o container está escutando, lembrando que estamos utilizando o nginx nesse exemplo, um webserver que escuta por padrão na porta 80.

```
kubectl run meu-nginx --image nginx --port 80 --dry-run=client -o yaml > pod-template.yaml
kubectl create -f pod-template.yaml
```

Liste os pods.

```
kubectl get pods

NAME    READY   STATUS    RESTARTS   AGE
meu-nginx   1/1     Running   0          32s
```

O comando a seguir cria um objeto do k8s chamado de _Service_, que é utilizado justamente para expor _pods_ para acesso externo.

```
kubectl expose pod meu-nginx
```

Podemos listar todos os _services_ com o comando a seguir.

```
kubectl get services

NAME         TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
kubernetes   ClusterIP   10.96.0.1       <none>        443/TCP   8d
nginx        ClusterIP   10.105.41.192   <none>        80/TCP    2m30s
```

Como é possível observar, há dois _services_ no nosso _cluster_: o primeiro é para uso do próprio k8s, enquanto o segundo foi o quê acabamos de criar.

&nbsp;

#### Limpando tudo e indo para casa

Para mostrar todos os recursos recém criados, pode-se utilizar uma das seguintes opções a seguir.

```
kubectl get all

kubectl get pod,service

kubectl get pod,svc
```

Note que o k8s nos disponibiliza algumas abreviações de seus recursos. Com o tempo você irá se familiar com elas. Para apagar os recursos criados, você pode executar os seguintes comandos.

```
kubectl delete -f pod-template.yaml
kubectl delete service nginx
```

Liste novamente os recursos para ver se os mesmos ainda estão presentes.

&nbsp;

1cp
3wp
meu-primeiro-cluster.yaml

deploy o pod

**DaemonSet and ReplicaSet** Não é possível utilizar o kubectl create para DaemonSet and ReplicaSet

```
minikube start --driver=virtualbox --nodes=3 --cpus 2 --memory 2200 disk 20000
minikube start --driver=virtualbox --nodes 1 --memory 4096 --cpus 2
minikube delete --purge
minikube addons list
minikube addons enable dashboard
minikube addons enable ingress
minikube addons enable metrics-server
```

## Time Saving Aliases for k8s certification exams

```
## General Aliases
alias k="kubectl"
alias ks="kubectl -n kube-system"
alias kdesc="kubectl describe"

## Create Resources
alias kcf="kubectl create -f"
alias kaf="kubectl apply -f"

## Get Resources
alias kgn="kubectl get nodes"
alias kgp="kubectl get pods"
alias kgpa="kubectl get pods --all-namespaces"
alias kgs="kubectl get services"
alias kgd="kubectl get deployments"

## Delete Resources
alias kd="kubectl delete"
alias kdp="kubectl delete pods"
alias kds="kubectl delete services"
alias kdd="kubectl delete deployments"
alias kdn="kubectl delete namespaces"
```

## 1.27 - Chill Vibes - 2023 - 60 melhorias

- The k8s.gcr.io image registry has been frozen (moved to registry.k8s.io)
- SeccompDefault has graduated to stable
- Node log access is now possible via the k8s API
- Mutable scheduling directives for jobs have graduated to GA, while mutable pod scheduling directives have gone to beta
- DownwardAPIHugePages has graduated to stable
- Pod scheduling Readiness has gone to beta
- ReadWriteOncePod PersistentVolume Access mode has also gone to beta
- We now faster selinux volume relabeling using mounts
- Robust volumemanager reconstruction has gone to beta

## 1.28

## 1.29

## 1.30

## 1.31

## Tips and Tricks
```~/.vimrc
set expandtab
set tabstop=2
set shiftwidth=2
``` 

```Log locations to check:
/var/log/pods
/var/log/containers
crictl ps + crictl logs
docker ps + docker logs (in case when Docker is used)
kubelet logs: /var/log/syslog or journalctl
```

```tmux
## debian and ubuntu
apt install tmux

## macos
brew install tmux

## How to use
tmux

tmux new -s <session_name>

tmux new -s cka
```