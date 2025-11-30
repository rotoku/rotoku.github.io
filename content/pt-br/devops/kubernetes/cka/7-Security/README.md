# Security

## Kubernetes Security Primitives

## Authentication
- Files - Username and Passwords
```user-details.csv
password,user_name,user_id
password123,user1,u0001
```

```user-details.csv
password,user_name,user_id,group_name
password123,user1,u0001,group1
```

```user-token-details.csv
token,user_name,user_id,group_name
mmcsçmçfmcçsmcçmcçlmçlfm,user1,u0001,group1
```

```/etc/kubernetes/manifests/kube-apiserver.yaml
  containers:
  - command:
    - kube-apiserver
    - --basic-auth-file=user-details.csv
    OR
    - --token-auth-file=user-token-details.csv
```

- Files - Username and Tokens
- Certificates
- External Authentication providers - LDAP
- ServiceAccounts

## TLS
1. What is TLS?
- Transport Layer Security (TLS), é um protocolo que garante a segurança na comunicação entre cliente e servidor
- Utiliza criptografia para proteger dados em trânsito

2. Symmetric vs Asymmetric?
- Criptografia Sincrona (Simétrica):
  - Usa a mesma chabe para criptografar e descriptografar os dados.
  - Mais rápida, mas a chave precisar ser compartilhada com segurança.
  - Exemplo: AES
- Criptografia Assincrona (Assimétrica):
  - Usa um par de chaves: Chave Pública e Chave Privada
  - A chave pública criptografa os dados, e a chave privada descriptografa.
  - Mais lenta, porém mais segura para o compartilhamento inicial.
  - Example: RSA

3. Certificados Digitais
- Um certificado digital é usado para:
  - Verificar a identidade de um servidor/cliente
  - Garantir a integridade e segurança da comunicação
- Contém a chave pública, informações da entidade (servidor/cliente) e a assinatura de uma Autoridade Certificadora (CA)

```
## client side
ssh-keygen
ls
id_rsa id_rsa.pub


## server side
cat ~/.ssh/authorized_keys
ssh-rsa BBlksmdlsmdlksamdlkasmdklamscdkmdakcml4l4cm04k98c4w-98-98rxn9t8c-9wry7-n9w7yn-9n7y-97ny-97q-9== fulano@gmail.com

## Gerar Chave Privada
openssl genrsa -out private.key 2048
ls
private.key

## Gerar uma chave pública a partir de uma chave privada
openssl rsa -in private.key -pubout > public.key
ls
private.key public.key


## criptografar com a chave publica (The command rsautl was deprecated in version 3.0. Use 'pkeyutl' instead.)
echo "Minha mensagem super secreta!" | openssl pkeyutl \
  -encrypt \
  -pubin \
  -inkey public.key \
  -out encrypted_message.txt

## descriptografar com a chave privada
openssl pkeyutl \
  -decrypt \
  -inkey private.key \
  -in encrypted_message.txt
```

## Authorization
- RBAC Authorization
- ABAC Authorization
- Node Authorization
- Webhook Mode


## Client Certificates
- kube-proxy
- controller-manager
- admin
- scheduler
- api-server
- kubelet

## Server Certificates
- api-server
- etcd
- kubelet

## Generate Certificates
```
# Generate Key
openssl genrsa -out ca.key 2048

# Certificate Signing Request
openssl req -new -key ca.key -subj "/CN=KUBERNETES-CA" -out ca.csr

# Sign Certificates
openssl x509 -req -in ca.csr -signkey ca.key -out ca.crt

## ADMIN USER
# Generate Key
openssl genrsa -out admin.key 2048

# Certificate Signing Request
openssl req -new -key admin.key -subj "/CN=kube-admin/O=system:masters" -out admin.csr

# Sign Certificates
openssl x509 -req -in admin.csr -signkey admin.key -out admin.crt


curl https://127.0.0.1:36467/api/v1/pods \
  --key /home/rkumabe/Desktop/client-key-data.key \
  --cert /home/rkumabe/Desktop/client-certificate-data.crt \
  --cacert /home/rkumabe/Desktop/ca.crt


openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

Run crictl ps -a command to identify the kube-api server container.
Run crictl logs container-id command to view the logs.

## Controller Manager
CSR-APPROVING and CSR-SIGNING
```

```CertificateSigningRequest.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: akshay
spec:
  groups:
  - system:authenticated
  signerName: kubernetes.io/kube-apiserver-client
  usages:
  - client auth
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZqQ0NBVDRDQVFBd0VURVBNQTBHQTFVRUF3d0dZV3R6YUdGNU1JSUJJakFOQmdrcWhraUc5dzBCQVFFRgpBQU9DQVE4QU1JSUJDZ0tDQVFFQXJCUWt4a1R1NTFkTXMzSlQ1SGQ4V24wNjhTU1hwSnE0dWNzRENnaTR1cS85ClR3am51cTFNMTZtUDZHVFdsczlldXIyVDdma3RSKzM4VVZPU0REekE3dDVRbXpqVG5aVzA1T1FiQW4vamFmQi8KUkdrbGhabGNLWEpQVjU0L2dnRUdsckpObnJQWG5tTnZuaGJaTjF5cjNUV25VODBSb21udzFxdGl6UnlWY1M1SApHYkNzNldWaFF4OTVScEg1NjhUY2pBQjVaWmVacjNqeEw5RTNRY0V3RE53WDg1WjBqVnRRUUdxNDZpUDNnSjlqCjRhRnkvRmM4K3hjVXgwUUdsU0pIN3FETEJJdmxNOEZqSmx2aUdLZUYrUytPbVByZ0xoYVY3Q3J3QVpTRDIxU0wKMmcvUjJrSDNhSFpKVGU0RHdieXhiT1BzSXZkOGZTK0VJUmtCSkVIK1dRSURBUUFCb0FBd0RRWUpLb1pJaHZjTgpBUUVMQlFBRGdnRUJBSHp3TGZ3RkowM2ZwQSttZ3EwSzgzbUdTTHFqN2NDNmJlK01HSUJYNENhdHhDekNFbmhsCkM3cWZWNXpuQ3RkRXZqSHAxbS9abS9HaTBlb3RhZUt3RUVRL3J3RkdmaWdyYVNuL0ZlNURQMjNSdm9JNTVHZ2MKWmJYWGQ1VW9xNDFxZmFkelhZVytKdDJrckZhT3lkSmlEU21qQVYvdXJhMzVRQ0RFeGZQUTB2QlVmSVVYbVNmeAoySjRad0Z4QjcwMnNwNEJHb1VZSldmZ1FmdFUvY1JEcmVSVUttUVpXWUVrMGd0cUJEL0V4R3Y1WEJkWWh3MDZvCk5iaEdnQitLcVkvTmpPQWVLVTFzODFUZWd5T29VSE5GcjNkUncvNmMzNVdYMXNWNUREMGNoUlNNTG1reXMvZmcKdjRqSVBYN2U4NEJCVktNNmI3T3BPOHFMeG5JQjBQTnJnYU09Ci0tLS0tRU5EIENFUlRJRklDQVRFIFJFUVVFU1QtLS0tLQo=
```


```Approve CSR
kubectl certificate approve akshay
```

```Reject CSR
kubectl certificate deny agent-smith
```

## kubeconfig
```
kubectl get pods --kubeconfig $HOME/.kube/config

To use that context, run the command: kubectl config --kubeconfig=/root/my-kube-config use-context research

To know the current context, run the command: kubectl config --kubeconfig=/root/my-kube-config current-context

export KUBECONFIG=/root/my-kube-config >> ~/.bashrc
```


## API Groups
```
curl https://127.0.0.1:36467 \
  --key /home/rkumabe/Desktop/client-key-data.key \
  --cert /home/rkumabe/Desktop/client-certificate-data.crt \
  --cacert /home/rkumabe/Desktop/ca.crt

curl https://127.0.0.1:36467/apis \
  --key /home/rkumabe/Desktop/client-key-data.key \
  --cert /home/rkumabe/Desktop/client-certificate-data.crt \
  --cacert /home/rkumabe/Desktop/ca.crt  

curl https://127.0.0.1:36467/healthz \
  --key /home/rkumabe/Desktop/client-key-data.key \
  --cert /home/rkumabe/Desktop/client-certificate-data.crt \
  --cacert /home/rkumabe/Desktop/ca.crt;echo
```

## Authorization

## Role Based Access Control
```role-developer.yaml
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
  - create
  - list
  - delete
```

```rolebinding-developer.yaml
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


```
kubectl auth can-i create deploy
kubectl auth can-i create sa
kubectl auth can-i get pod --as dev-user -n blue
kubectl auth can-i list pods --as dev-user
kubectl auth can-i create sa --as dev-user -n blue
kubectl auth can-i get pod --as dev-user -n blue
kubectl auth can-i get pod --as dev-user -n blue
kubectl auth can-i get pod/dark-blue-app --as dev-user -n blue
kubectl auth can-i create deploy --as dev-user -n blue
```

## Cluster Scoped
```
$ kubectl api-resources --namespaced=false
NAME                                SHORTNAMES   APIVERSION                        NAMESPACED   KIND
componentstatuses                   cs           v1                                false        ComponentStatus
namespaces                          ns           v1                                false        Namespace
nodes                               no           v1                                false        Node
persistentvolumes                   pv           v1                                false        PersistentVolume
.
.
.
```

- ClusterRole
```
k get ClusterRole
k get ClusterRole --no-headers | wc -l
k get ClusterRole | grep cluster-admin
```

- ClusterRoleBinding
``` 
k get ClusterRoleBinding
k get ClusterRoleBinding --no-headers | wc -l
k get ClusterRoleBinding | grep "cluster-admin"
``` 

```michelle-cluster-role.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  labels:
    kubernetes.io/bootstrapping: rbac-defaults
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

``storage-admin.yaml
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: storage-admin
rules:
- apiGroups:
  - 'apis'
  resources:
  - 'persistentvolumes'
  - 'storageclasses'
  verbs:
  - '*'
```

```michelle-cluster-role-binding.yaml
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

## Service Account
```
## Afteer k8s 1.24
k create serviceaccount dashboard-sa
k create token dashboard-sa
```

eyJhbGciOiJSUzI1NiIsImtpZCI6IlJ4bXJ3T1lVZTlrQ2RQQWR0Wmh1MExrak04WENqSnh6cDB1WlM2Z19Hbm8ifQ.eyJhdWQiOlsiaHR0cHM6Ly9rdWJlcm5ldGVzLmRlZmF1bHQuc3ZjLmNsdXN0ZXIubG9jYWwiLCJrM3MiXSwiZXhwIjoxNzM0OTc3OTQ0LCJpYXQiOjE3MzQ5NzQzNDQsImlzcyI6Imh0dHBzOi8va3ViZXJuZXRlcy5kZWZhdWx0LnN2Yy5jbHVzdGVyLmxvY2FsIiwianRpIjoiZjhiNDRiN2EtNWVmMi00NWExLWI4ZDctZTFhYmFjZjNlY2E1Iiwia3ViZXJuZXRlcy5pbyI6eyJuYW1lc3BhY2UiOiJkZWZhdWx0Iiwic2VydmljZWFjY291bnQiOnsibmFtZSI6ImRhc2hib2FyZC1zYSIsInVpZCI6IjRiNDg3N2FhLWI0N2ItNGJiMC1hYmZmLTBjMzU0N2JlOGU3NiJ9fSwibmJmIjoxNzM0OTc0MzQ0LCJzdWIiOiJzeXN0ZW06c2VydmljZWFjY291bnQ6ZGVmYXVsdDpkYXNoYm9hcmQtc2EifQ.lWKkbFoTDRN-g0VVtgraK3MiFcNR9QaPtwnHY-wX8Wi2QVzg1LQQ7xEXlK3JNWwDVMWAChE8QKafFP-QKEC0Tszoa4zSlbIFE2lz7OFwqp5R8HwbDlJKZDgxqOLoAir1XKLkU4LK19Io-as9QRztFa5E39yA0wdz_Dr1gIA6RT5FOIDAsAPMIi4RhS9EJFtzckVJRuRRdFxQ1B8NkMJ_GfWiU8x358RJjD5TUrL--4_ef-L5Bzbz7daIUadLEgHWJJx9AJP5Atmrb7JUqot_DWxsqRB3ssXcZbpEwsVC33D_SVYr5UBu4exx6FrWEIoIWabIo6nRrcVsKOkpaujQiQ

```dashboard-sa-role-binding.yaml
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

```
apiVersion: v1
kind: Secret
type: kubernetes.io/service-account-token
metadata:
  name: mysecretname
  annotations:
    kubernetes.io/service-account.name: dashboard-sa
```

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: web-dashboard
  namespace: default
spec:
  replicas: 1
  selector:
    matchLabels:
      name: web-dashboard
  strategy:
    rollingUpdate:
      maxSurge: 25%
      maxUnavailable: 25%
    type: RollingUpdate
  template:
    metadata:
      creationTimestamp: null
      labels:
        name: web-dashboard
    spec:
      serviceAccountName: dashboard-sa
      containers:
      - env:
        - name: PYTHONUNBUFFERED
          value: "1"
        image: gcr.io/kodekloud/customimage/my-kubernetes-dashboard
        imagePullPolicy: Always
        name: web-dashboard
        ports:
        - containerPort: 8080
          protocol: TCP
```

## Security Context

```private-reg-cred.yaml
k create secret docker-registry private-reg-cred \
    --docker-username=dock_user \
    --docker-password=dock_password \
    --docker-email=dock_user@myprivateregistry.com \
    --docker-server=myprivateregistry.com:5000
```

```nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  imagePullSecrets:
  - name: private-reg-cred  
  containers:
  - image: myprivate-registry.io:5000/nginx
    name: nginx
    ports:
      - containerPort: 80
```

```
cat /usr/include/linux/capability.h


docker run --user=1001 ubuntu sleep 3600

docker run --cap-add MAC_ADMIN ubuntu
```


```nginx.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: nginx
  name: nginx
spec:
  containers:
  - image: nginx
    name: nginx
    ports:
      - containerPort: 80
    securityContext:
      runAsUser: 1000
      capabilities:
        add: ["MAC_ADMIN"]
``` 

## Networking Policy
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: internal-policy
  namespace: default
spec:
  ingress:
  - {}  
  egress:
  - to:
    - podSelector:
        matchLabels:
          name: mysql
    ports:
    - port: 3306
      protocol: TCP
  - to:
    - podSelector:
        matchLabels:
          name: payroll
    ports:
    - port: 8080
      protocol: TCP
  - ports:
    - port: 53
      protocol: UDP
  - ports:
    - port: 53
      protocol: TCP
  podSelector:
    matchLabels:
      name: internal
  policyTypes:
  - Ingress
  - Egress
```  