# Lab- Kubernetes Challenge 2

This 2-Node Kubernetes cluster is broken! Troubleshoot, fix the cluster issues and then deploy the objects according to the given architecture diagram to unlock our Image Gallery!!

Click on each icon (including arrows) to see more details. Once done click on Check button to test your work.

```
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config

systemctl restart kubelet

controlplane /var/log/pods ✖ cat kube-system_kube-apiserver-controlplane_561267cb3fafbb04548c3e6637c2b936/kube-apiserver/13.log
2024-07-31T08:56:27.721843625Z stderr F I0731 08:56:27.721622       1 options.go:222] external host was not specified, using 192.13.89.12
2024-07-31T08:56:27.722662971Z stderr F I0731 08:56:27.722569       1 server.go:148] Version: v1.29.0
2024-07-31T08:56:27.722680077Z stderr F I0731 08:56:27.722595       1 server.go:150] "Golang settings" GOGC="" GOMAXPROCS="" GOTRACEBACK=""
2024-07-31T08:56:28.035799817Z stderr F E0731 08:56:28.035574       1 run.go:74] "command failed" err="open /etc/kubernetes/pki/ca-authority.crt: no such file or directory"

controlplane /var/log/pods ➜  ls -l /etc/kubernetes/pki/
total 60
-rw-r--r-- 1 root root 1289 Jul 31 06:57 apiserver.crt
-rw-r--r-- 1 root root 1123 Jul 31 06:57 apiserver-etcd-client.crt
-rw------- 1 root root 1675 Jul 31 06:57 apiserver-etcd-client.key
-rw------- 1 root root 1675 Jul 31 06:57 apiserver.key
-rw-r--r-- 1 root root 1176 Jul 31 06:57 apiserver-kubelet-client.crt
-rw------- 1 root root 1679 Jul 31 06:57 apiserver-kubelet-client.key
-rw-r--r-- 1 root root 1107 Jul 31 06:57 ca.crt
-rw------- 1 root root 1675 Jul 31 06:57 ca.key
drwxr-xr-x 2 root root 4096 Jul 31 06:57 etcd
-rw-r--r-- 1 root root 1123 Jul 31 06:57 front-proxy-ca.crt
-rw------- 1 root root 1679 Jul 31 06:57 front-proxy-ca.key
-rw-r--r-- 1 root root 1119 Jul 31 06:57 front-proxy-client.crt
-rw------- 1 root root 1679 Jul 31 06:57 front-proxy-client.key
-rw------- 1 root root 1675 Jul 31 06:57 sa.key
-rw------- 1 root root  451 Jul 31 06:57 sa.pub

controlplane /var/log/pods ➜  cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep crt
    - --client-ca-file=/etc/kubernetes/pki/ca-authority.crt
    - --etcd-cafile=/etc/kubernetes/pki/etcd/ca.crt
    - --etcd-certfile=/etc/kubernetes/pki/apiserver-etcd-client.crt
    - --kubelet-client-certificate=/etc/kubernetes/pki/apiserver-kubelet-client.crt
    - --proxy-client-cert-file=/etc/kubernetes/pki/front-proxy-client.crt
    - --requestheader-client-ca-file=/etc/kubernetes/pki/front-proxy-ca.crt
    - --tls-cert-file=/etc/kubernetes/pki/apiserver.crt

vim /etc/kubernetes/manifests/kube-apiserver.yaml

systemctl restart kubelet

systemctl status kubelet


controlplane /var/log/pods ➜  k get pods -A
NAMESPACE     NAME                                   READY   STATUS             RESTARTS       AGE
kube-system   coredns-68c587dd4c-vzsx9               0/1     ImagePullBackOff   0              31m
kube-system   coredns-68c587dd4c-wspd4               0/1     ImagePullBackOff   0              31m
kube-system   etcd-controlplane                      1/1     Running            0              126m
kube-system   kube-apiserver-controlplane            1/1     Running            0              126m
kube-system   kube-controller-manager-controlplane   1/1     Running            1 (30m ago)    126m
kube-system   kube-proxy-82lwc                       1/1     Running            0              125m
kube-system   kube-proxy-l4j82                       1/1     Running            0              126m
kube-system   kube-scheduler-controlplane            1/1     Running            1 (30m ago)    126m
kube-system   weave-net-cqh6s                        2/2     Running            0              125m
kube-system   weave-net-dwmdj                        2/2     Running            1 (126m ago)   126m


k describe pod coredns-68c587dd4c-wspd4 -n kube-system
.
.
.
Events:
  Type     Reason       Age                   From               Message
  ----     ------       ----                  ----               -------
  Normal   Scheduled    32m                   default-scheduler  Successfully assigned kube-system/coredns-68c587dd4c-wspd4 to node01
  Warning  FailedMount  9m50s                 kubelet            MountVolume.SetUp failed for volume "kube-api-access-r5f84" : failed to fetch token: Post "https://controlplane:6443/api/v1/namespaces/kube-system/serviceaccounts/coredns/token": read tcp 192.13.89.3:34648->192.13.89.12:6443: read: connection reset by peer
  Warning  FailedMount  7m48s (x11 over 32m)  kubelet            MountVolume.SetUp failed for volume "kube-api-access-r5f84" : failed to fetch token: Post "https://controlplane:6443/api/v1/namespaces/kube-system/serviceaccounts/coredns/token": dial tcp 192.13.89.11:6443: connect: connection refused
  Warning  FailedMount  3m44s (x10 over 32m)  kubelet            MountVolume.SetUp failed for volume "kube-api-access-r5f84" : failed to fetch token: Post "https://controlplane:6443/api/v1/namespaces/kube-system/serviceaccounts/coredns/token": dial tcp 192.13.89.12:6443: connect: connection refused
  Warning  Failed       101s                  kubelet            Error: ImagePullBackOff
  Normal   Pulling      89s (x2 over 101s)    kubelet            Pulling image "registry.k8s.io/kubedns:1.3.1"
  Warning  Failed       89s (x2 over 101s)    kubelet            Failed to pull image "registry.k8s.io/kubedns:1.3.1": rpc error: code = NotFound desc = failed to pull and unpack image "registry.k8s.io/kubedns:1.3.1": failed to resolve reference "registry.k8s.io/kubedns:1.3.1": registry.k8s.io/kubedns:1.3.1: not found
  Warning  Failed       89s (x2 over 101s)    kubelet            Error: ErrImagePull
  Normal   BackOff      74s (x2 over 101s)    kubelet            Back-off pulling image "registry.k8s.io/kubedns:1.3.1"
.
.
.

kubectl set image deployment/coredns -n kube-system coredns=registry.k8s.io/coredns/coredns:v1.8.6

controlplane /var/log/pods ➜  k get node
NAME           STATUS                     ROLES           AGE    VERSION
controlplane   Ready                      control-plane   132m   v1.29.0
node01         Ready,SchedulingDisabled   <none>          131m   v1.29.0

controlplane /var/log/pods ➜  kubectl uncordon node01
node/node01 uncordoned

controlplane /var/log/pods ➜  k get node
NAME           STATUS   ROLES           AGE    VERSION
controlplane   Ready    control-plane   132m   v1.29.0
node01         Ready    <none>          131m   v1.29.0

controlplane /var/log/pods ➜  scp /media/* node01:/web

### data-pv
cat <<EOF > fileserver-pv.yaml
---
kind: PersistentVolume
apiVersion: v1
metadata:
    name: data-pv
spec:
   accessModes: ["ReadWriteMany"]
   capacity:
    storage: 1Gi
   hostPath:
      path: /web
      type: DirectoryOrCreate
EOF

kubectl apply -f ./fileserver-pv.yaml

### data-pvc
cat <<EOF > fileserver-pvc.yaml
---
kind: PersistentVolumeClaim
apiVersion: v1
metadata:
    name: data-pvc
spec:
   accessModes: ["ReadWriteMany"]
   resources:
    requests:
       storage: 1Gi
   volumeName: data-pv
EOF
kubectl apply -f ./fileserver-pvc.yaml

### gop-file-server
cat <<EOF > fileserver-pod.yaml
---
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: gop-file-server
  name: gop-file-server
spec:
  volumes:
  - name: data-store
    persistentVolumeClaim:
      claimName: data-pvc
  containers:
  - image: kodekloud/fileserver
    imagePullPolicy: IfNotPresent
    name: gop-file-server
    volumeMounts:
       - name: data-store
         mountPath: /web
  dnsPolicy: ClusterFirst
  restartPolicy: Never
EOF
kubectl apply -f ./fileserver-pod.yaml

### gop-fx-service
cat <<EOF > fileserver-svc.yaml
---
apiVersion: v1
kind: Service
metadata:
  creationTimestamp: null
  labels:
    app: gop-fs-service
  name: gop-fs-service
spec:
  ports:
  - name: 8080-8080
    port: 8080
    protocol: TCP
    targetPort: 8080
    nodePort: 31200
  selector:
    run: gop-file-server
  type: NodePort
EOF
kubectl apply -f ./fileserver-svc.yaml

### Validate pv & pvc
kubectl get pv
kubectl get pvc

### Validate pod
kubectl get pods

```
