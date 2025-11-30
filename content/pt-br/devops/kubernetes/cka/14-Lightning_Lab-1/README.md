# Lightning Lab - 1

## Question#1
Upgrade the current version of kubernetes from 1.30.0 to 1.31.0 exactly using the kubeadm utility. Make sure that the upgrade is carried out one node at a time starting with the controlplane node. To minimize downtime, the deployment gold-nginx should be rescheduled on an alternate node before upgrading each node.
Upgrade controlplane node first and drain node node01 before upgrading it. Pods for gold-nginx should run on the controlplane node subsequently.

```controlplane
kubectl drain controlplane --ignore-daemonsets

cp /etc/apt/sources.list.d/kubernetes.list /etc/apt/sources.list.d/kubernetes.list~

vim /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt-cache madison kubeadm

1.31.0-1.1

sudo apt-mark unhold kubelet kubectl kubeadm && \
sudo apt-get update && sudo apt-get install -y kubelet='1.31.0-1.1' kubectl='1.31.0-1.1' kubeadm='1.31.0-1.1' && \
sudo apt-mark hold kubelet kubectl kubeadm

kubelet --version
kubectl version
kubeadm version

# replace x with the patch version you picked for this upgrade
sudo kubeadm upgrade plan v1.31.0
sudo kubeadm upgrade apply v1.31.0


sudo systemctl daemon-reload
sudo systemctl restart kubelet

sudo kubectl uncordon controlplane
```

```node01
kubectl drain node01 --ignore-daemonsets

cp /etc/apt/sources.list.d/kubernetes.list /etc/apt/sources.list.d/kubernetes.list~

vim /etc/apt/sources.list.d/kubernetes.list

sudo apt update
sudo apt-cache madison kubeadm

sudo apt-mark unhold kubelet kubectl kubeadm && \
sudo apt-get update && sudo apt-get install -y kubelet='1.31.0-1.1' kubectl='1.31.0-1.1' kubeadm='1.31.0-1.1' && \
sudo apt-mark hold kubelet kubectl kubeadm

sudo systemctl daemon-reload
sudo systemctl restart kubelet

kubelet --version
kubectl version
kubeadm version

sudo kubectl uncordon node01
```

## Question#2
Print the names of all deployments in the admin2406 namespace in the following format:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE

<deployment name>   <container image used>   <ready replica count>   <Namespace>
. The data should be sorted by the increasing order of the deployment name.


Example:

DEPLOYMENT   CONTAINER_IMAGE   READY_REPLICAS   NAMESPACE
deploy0   nginx:alpine   1   admin2406
Write the result to the file /opt/admin2406_data.

```
kubectl get deploy -n admin2406 -o custom-columns=DEPLOYMENT:.metadata.name,CONTAINER_IMAGE:.spec.template.spec.containers[*].image,READY_REPLICAS:.spec.replicas,NAMESPACE:.metadata.namespace > /opt/admin2406_data

cat /opt/admin2406_data
```

##Question#3
A kubeconfig file called admin.kubeconfig has been created in /root/CKA. There is something wrong with the configuration. Troubleshoot and fix it.

```
apiVersion: v1
clusters:
- cluster:
    certificate-authority-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURCVENDQWUyZ0F3SUJBZ0lJYXlSWDF3R0xoU293RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBeE1EZ3hNelE1TkRKYUZ3MHpOVEF4TURZeE16VTBOREphTUJVeApFekFSQmdOVkJBTVRDbXQxWW1WeWJtVjBaWE13Z2dFaU1BMEdDU3FHU0liM0RRRUJBUVVBQTRJQkR3QXdnZ0VLCkFvSUJBUUN5VXp3K0hwSytsL2gzZzBVc1ArUzV1WVBWWmhMNk93dm5TZ1VZTW1veUFiN3VLMi94ZXczeGFybVIKRk5zeDhHbTVORk01Z3Jqc09EbjJTM2NkSmswTUhnSG1SeXhZeTZ0YVkxNDRGSjBVRzNIb2dOcEsvdzg0VldYYgo1ZmtOenE0UlBRN0JGTVdWbXdWUDd0S0NBTDk1cEhGeTVmNnhLbGlwekxOdHNoS2UyNVZ6QVBjMTVSRGx5MDNnCk01S3ZaVzFhQlZqa2lZbXo1TmFtUHVkblkwcjdWWVhTcmV1Y3lkMkdZV2czcldsWEFCc09DbkNZR0tlcFJIZ1YKREVKdk9ndnVVczV6ak9uVmpCTVl5Z1c1dUJZV2R0SnNndjUzQWU0Sm44eGFxWnJDS2lETGVKQ3c2R3RPeTBBbApmd3lHcUJWVVpianptRU5HWERpZGRxaUhOTHgxQWdNQkFBR2pXVEJYTUE0R0ExVWREd0VCL3dRRUF3SUNwREFQCkJnTlZIUk1CQWY4RUJUQURBUUgvTUIwR0ExVWREZ1FXQkJTQ2oxYmo4RE96Y1g3NFExdDNPekM0a250RVRqQVYKQmdOVkhSRUVEakFNZ2dwcmRXSmxjbTVsZEdWek1BMEdDU3FHU0liM0RRRUJDd1VBQTRJQkFRQTNYRUFNdWk1WgplMDZHZWdZbFFIV3hGRkdCNzlxQjQ4ZzhCL05ZaFhJb2V6L3JncWxpVTVGbVg3eHh4NmgrY1NMbWFyVGlGTkVCClQrc1o4ZWdIYTNDcU5JeGYzSVRiSHQyWGhUcnd1KzBPRkZweFZaRTJpUjJnUERMeUFOL1lEMUNCN1R3VllWZ3cKMzl5ekVYdVhsSHY3S1BXSGdmQmJjZDZJTTRWOUxFbCtqYjJVRHBibk40akNZZFlxbmVFa214YjlwbFhHWTBwKwpTTmFHVUJ5ZWRHQlhwQ2MzVlI3RFZkaGZDcnNISFRPTHpxV2g4Qk9kNmZlelZCcE9aRDJrM0ZQWS9aL2VjUFlnCm91cVJxMWgxZm41SEF2L0Zmb1V3ako1dmJuaHBqWVdJWDZNYWx4NU81ZCtvNmRobHFTcThJZTl6anhXKzdzWjEKclhDRUhOdDVDK2d1Ci0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    server: https://controlplane:6443
  name: kubernetes
contexts:
- context:
    cluster: kubernetes
    user: kubernetes-admin
  name: kubernetes-admin@kubernetes
current-context: kubernetes-admin@kubernetes
kind: Config
preferences: {}
users:
- name: kubernetes-admin
  user:
    client-certificate-data: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSURLVENDQWhHZ0F3SUJBZ0lJUkJLRG9oUGo0OGt3RFFZSktvWklodmNOQVFFTEJRQXdGVEVUTUJFR0ExVUUKQXhNS2EzVmlaWEp1WlhSbGN6QWVGdzB5TlRBeE1EZ3hNelE1TkRKYUZ3MHlOakF4TURneE16VTBORE5hTUR3eApIekFkQmdOVkJBb1RGbXQxWW1WaFpHMDZZMngxYzNSbGNpMWhaRzFwYm5NeEdUQVhCZ05WQkFNVEVHdDFZbVZ5CmJtVjBaWE10WVdSdGFXNHdnZ0VpTUEwR0NTcUdTSWIzRFFFQkFRVUFBNElCRHdBd2dnRUtBb0lCQVFDNENRUU8KMkpyczlHR0U1TVlQMUVyVGh4R0FubTA4MDZ6OVYvM01PbG9zL1ZSc2hBa1RJRTN5TURWY002bnB6ZW9ONGxqbgpJSkYxaEFubHVlQ1R1cm9HYU4zMGUwUElwRFZ3MVlLcnI5MFNManFPWlVJRTRtcytxaVpFNTVwTVBCY1lOS0g2CkIzZllyOTV0bVQzUEF0YWZISkNZTVdUOVhjeU9KRDNCUGpZZkkrYTIxNUxzSklXL294aGFjQnRmWkMwTGtVQTEKcGpmYnl2endBbitGOEhpcEVtK1c1eGJvelBXMk9SQ3JIS3ViYTRib3RjbGd1VXNtZWdVWVkraU1qc0I5TkphKwpZRUluWHM5dldJUEtvZzlFby83eEZXRGtjd3dlSE81ZURGSW5pblpsdWNpdTVKRmt5UHdNZ2xFRVJ1dnJUUEZkCjhvVGNRajFmRmpzM0NVMUxBZ01CQUFHalZqQlVNQTRHQTFVZER3RUIvd1FFQXdJRm9EQVRCZ05WSFNVRUREQUsKQmdnckJnRUZCUWNEQWpBTUJnTlZIUk1CQWY4RUFqQUFNQjhHQTFVZEl3UVlNQmFBRklLUFZ1UHdNN054ZnZoRApXM2M3TUxpU2UwUk9NQTBHQ1NxR1NJYjNEUUVCQ3dVQUE0SUJBUUFGQ0dPcFozdWFpZ2ZINytQU21hYzJabDgwCkVLQVpKMlJkMUZ4d1ZNdGI4NlVzZUkxMUlsYzlHaUM4MDhvVU0zUHNNVVFMdXYxMzJhSlcwQzRUQ3hTOHdid0gKaWsvV3JlNkFWMkdCUFNyZ3d1aGcxbzEwNG83d2trVFpOMFRzdnJpalluZVRGL0NjQmYyZERjaW4wS3dCUDF2QQpsTUtseDZqRWhMUVF1ZVJhS3ZvRjFSSXJ4Nmt3UXFXRTdkKytBWmFRdkVmSHFtdmtqd2tFZlBqSXRiSkVXR3JECkNUcEJRSnNicldnN3ltZkVhUzdHOFNXNFZGOHhsaUhIeHo0N3JxTitNaEJtS2FneDcvdElUYjdPRkhzOXRuTXMKS3lUbEZNRWlTSUpRY0hlanJWWnNmVUpIa1JTNWhwbVNEUm1iK1ZtRWZkQjU5Qzk3VmdVQnpvTmh0NktPCi0tLS0tRU5EIENFUlRJRklDQVRFLS0tLS0K
    client-key-data: LS0tLS1CRUdJTiBSU0EgUFJJVkFURSBLRVktLS0tLQpNSUlFcEFJQkFBS0NBUUVBdUFrRUR0aWE3UFJoaE9UR0Q5UkswNGNSZ0o1dFBOT3MvVmY5ekRwYUxQMVViSVFKCkV5Qk44akExWERPcDZjM3FEZUpZNXlDUmRZUUo1Ym5nazdxNkJtamQ5SHREeUtRMWNOV0NxNi9kRWk0NmptVkMKQk9KclBxb21ST2VhVER3WEdEU2grZ2QzMksvZWJaazl6d0xXbnh5UW1ERmsvVjNNamlROXdUNDJIeVBtdHRlUwo3Q1NGdjZNWVduQWJYMlF0QzVGQU5hWTMyOHI4OEFKL2hmQjRxUkp2bHVjVzZNejF0amtRcXh5cm0ydUc2TFhKCllMbExKbm9GR0dQb2pJN0FmVFNXdm1CQ0oxN1BiMWlEeXFJUFJLUCs4UlZnNUhNTUhoenVYZ3hTSjRwMlpibkkKcnVTUlpNajhESUpSQkVicjYwenhYZktFM0VJOVh4WTdOd2xOU3dJREFRQUJBb0lCQUJha1RWS0NSYlZIYjhRSQozWEZQSGhHZU9ZSUllOG9UQk9KNmMrZ3ZlYTYxVURDMW9lUXZna2Q4dE9QdUcwWi9wZjhsVE9qS3NmcXlUd0ZyCmQvelU2VlFtak1BcWRqRjJPbmp5Vzh4QnE4SXoyOUp2Rk10RERBeStwRXl2N2VUWk04SXZuNG9DWnpWS2xlUUkKQ1hteGtMUXNzSUY0K2tMTnluL21aNDZoMThqR3pZODNsdGpOTHNNcmZVTG5hajdwcFc3cng3a2NGTmR5MlNubgo2WkZUTEo3RTVtWFpMM25YemVGSCtacXRxR0Q0U09xbjI1K2dJZ2toVHhqZzREcjlBcXh1NnZ1MXk3eEM3ai8yCkM1Z2pxUVpFd1VBTjBvNXk3eXhZVVdHZXhYTzNJV2pMcElhZnhHRDM4em5wdmZMS3daNFkwaTl3WFlXdWpWVVYKVWNweEFBRUNnWUVBMjJWK1ZBTkozUkpHMHZxSE1hWDQ3L0ZzTXJUYXNOTUZqWW56NUdkWXJDa2ZnaUQ1Y2Uzdwo2V0pDaW1uWnFVR1YveGF6NGVOa0xhVmpDNmE5ZzFRTXlDMWxNT2tsdi9nNVVnRFRqa1dvRzRoWExKdElBQjM0CmZvTCtMMFk3QjYycFhoTmxEWk1RTHFEWi8xVE5zaXJ3VkF2T1lzRTJLcjkvUGc0WXgwNTdBQUVDZ1lFQTFyMDYKOUVqbG1FQlNzMWdUN2UvSFBUWUwwcVJrbUhyYjFNaTd5WGVJWnQ2MHdYNjBXM0l5NUtOSGJVOTZPSGIxb2lTWQpwTzBod1NyQUthcUwrZGk5L1BjRXVYbGlCZW00U1J4MzFDVDAxY3d1bkdYbHJkc0pnT1duUjY3eFN1ZTNObnlHCmFNM242WFVHUVBQZmJJSWhaaWhBV1pUZ1F5LzMxQzREUERvQVRVc0NnWUFNV1gwdjYzTjM3elJ2WWN6RVhheFMKalV0aTIwMUlFTWpLTzg2dnQ2V0ZJMWR6c3JsMzBVWHpUU1dqdHV1YW5HZCtFV0FVd2dEOGxNZXJlenBGcnpCOQpBQmtuRktpY1VyT2ZTdzZkZm94RTZIckh0d0hwaDhaYUVMT1FJNnJrOXNDRzNCNmZFZjBpTXNteWxxcHhjZnRQCkw4N3hQaUQzYlFvVGl5V1g2bklBQVFLQmdRREdqS2paL2h6cnJXM0tEWUkvMmhocWJISjZEUzVHSGpMc2g3MjYKQmgvRW5kNmJtai9BM2RKWXZPL3FEaloveHQ1UFVXOGg3Mi9xWDFEV05hNi9FTHg2RFJ2OU1sS0VEUm9yMzNxYwpXSjlZbnpYcHZmMmp4b2IrKzFpMFd2a1h2VEFWM1FXYUdlaDRYNCtzdHRDNlQ0ZjZJUFYrM3J5TTR1bE84a3hqCmYyMlFDUUtCZ1FDYXRwWGxrajRZNzdQOGdXdkVSQmVUUUxlWDI5WEZuOXVFRXpUVG9sUnRaak82L1ZoZEJ6SjIKb0c4Y2N4Tzc4M2VtaThvUDhyU1VFdVRsWmdYUXNYa21SZXhlQlBXVWJUV0hiVzR2bWxQbkRtajNVRlFHNXpqTApaSlpxcUMya1V1RlVjMVFOYjVJMzM2T3lsbnJZZFNoTHRGbDY5S3E2d2ZteEFDVnl1UzlkWkE9PQotLS0tLUVORCBSU0EgUFJJVkFURSBLRVktLS0tLQo=
```

##Question#4
Create a new deployment called nginx-deploy, with image nginx:1.16 and 1 replica.
Next, upgrade the deployment to version 1.17 using rolling update and add the annotation message
Updated nginx image to 1.17.

```
kubectl create deploy nginx-deploy --image=nginx:1.16 --replicas=1
kubectl edit deploy nginx-deploy
kubectl annotate deploy nginx-deploy message="Updated nginx image to 1.17"
```

##Question#5
A new deployment called alpha-mysql has been deployed in the alpha namespace. However, the pods are not running. Troubleshoot and fix the issue. The deployment should make use of the persistent volume alpha-pv to be mounted at /var/lib/mysql and should use the environment variable MYSQL_ALLOW_EMPTY_PASSWORD=1 to make use of an empty root password.


Important: Do not alter the persistent volume.

```
k get deploy alpha-mysql -n alpha

controlplane ~/CKA ➜  k get pvc -n alpha
NAME          STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   VOLUMEATTRIBUTESCLASS   AGE
alpha-claim   Pending  

controlplane ~/CKA ➜  k get pv -n alpha
NAME       CAPACITY   ACCESS MODES   RECLAIM POLICY   STATUS      CLAIM   STORAGECLASS   VOLUMEATTRIBUTESCLASS   REASON   AGE
alpha-pv   1Gi        RWO            Retain           Available           slow           <unset>                          49m

k get deploy alpha-mysql -n alpha -o yaml > alpha-mysql.yaml~
k edit deploy alpha-mysql -n alpha
```

```mysql-alpha-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-alpha-pvc
  namespace: alpha
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 1Gi
  storageClassName: slow
```

```alpha-pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"PersistentVolume","metadata":{"annotations":{},"name":"alpha-pv"},"spec":{"accessModes":["ReadWriteOnce"],"capacity":{"storage":"1Gi"},"hostPath":{"path":"/opt/pv-1"},"storageClassName":"slow"}}
  creationTimestamp: "2025-01-08T20:54:37Z"
  finalizers:
  - kubernetes.io/pv-protection
  name: alpha-pv
  resourceVersion: "2878"
  uid: 14346e57-6703-48c6-b6a7-3695dd0bba10
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 1Gi
  hostPath:
    path: /opt/pv-1
    type: ""
  persistentVolumeReclaimPolicy: Retain
  storageClassName: slow
  volumeMode: Filesystem
status:
  lastPhaseTransitionTime: "2025-01-08T20:54:37Z"
  phase: Available
```

##Question#6
Take the backup of ETCD at the location /opt/etcd-backup.db on the controlplane node.

```
export ETCDCTL_API=3
etcdctl snapshot \
 --cacert="/etc/kubernetes/pki/etcd/ca.crt" \
 --cert="/etc/kubernetes/pki/apiserver-etcd-client.crt" \
 --key="/etc/kubernetes/pki/apiserver-etcd-client.key" \
  save /opt/etcd-backup.db
```

##Question#7
Create a pod called secret-1401 in the admin1401 namespace using the busybox image. The container within the pod should be called secret-admin and should sleep for 4800 seconds.

The container should mount a read-only secret volume called secret-volume at the path /etc/secret-volume. The secret being mounted has already been created for you and is called dotfile-secret.


```secret-1401.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: secret-1401
  name: secret-1401
  namespace: admin1401
spec:
  containers:
  - image: busybox
    name: secret-admin
    command:
    - "sh"
    - "-c"
    - "sleep 4800"    
    volumeMounts:
    - name: secret-volume
      mountPath: "/etc/secret-volume"
      readOnly: true
  volumes:
  - name: secret-volume
    secret:
      secretName: dotfile-secret
```