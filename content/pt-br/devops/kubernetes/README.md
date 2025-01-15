# Kubernetes

## Sobre as provas
- As provas tem em média 17 questões
- Com duração de 2 horas = 120 minutos
- Uma média de 7 minutos por questão
- Sendo necessário ter 12 acertos de 17 para passar (66% de 17)

## CKA
01. Backup ETC
etcdctl snapshot \
    --endpoints=https://[172.18.0.5]:2379 \
    --cacert="/etc/kubernetes/pki/etcd/ca.crt" \
    --cert="/etc/kubernetes/pki/apiserver-etcd-client.crt" \
    --key="/etc/kubernetes/pki/apiserver-etcd-client.key" \
    save /opt/etcd-backup.db

02. Restore ETC
- Precisa do parâmetro endpoints?

03. Cronjob and create job from it

04. Ingress

05. Networking Policy

06. Install control plane and work node using kubeadm
- /etc/apt/sources.list.d/kubernetes.list

07. Secrets and ConfigMap
- env
- envFrom
- volumes
08. Upgrade control plane and work node using kubeadm to specific version
- kubectl drain <NODE> --ignore-daemonsets
- /etc/apt/sources.list.d/kubernetes.list


- kubectl uncordon <NODE>

09. Join a Node to the cluster

10. Cluster Troubleshoot (kubelet)

11. Reschedule pods to another nodes

12.
13.
14.
15.
16.
17.

## CKAD
01. Create Deployment and scale down and scale up
02. Create services (NodePort, ClusterIP)
03. Cronjob and create job from it
04. Ingress
05. Networking Policy
06. Create image based on oci
07. Secrets and ConfigMap
08. Privilégios dos pods (SecurityContext)
09. NodeAffinity
10.
11.
12.
13.
14.
15.
16.
17.

## CKS
01.
02.
03.
04.
05.
06.
07.
08.
09.
10.
11.
12.
13.
14.
15.
16.
17.