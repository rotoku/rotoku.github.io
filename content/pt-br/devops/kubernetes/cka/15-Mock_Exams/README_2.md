# Mock Exams

## Q1
Take a backup of the etcd cluster and save it to /opt/etcd-backup.db.


```
export ETCDCTL_API=3
etcdctl snapshot -h
kubectl get pods -n kube-system
kubectl get pods kube-apiserver-controlplane -n kube-system -o yaml

etcdctl snapshot \
    --cacert="/etc/kubernetes/pki/etcd/ca.crt" \
    --cert="/etc/kubernetes/pki/apiserver-etcd-client.crt" \
    --key="/etc/kubernetes/pki/apiserver-etcd-client.key" \
    save /opt/etcd-backup.db

ls -lrth --color /opt/etcd-backup.db    
```

## Q2
Create a Pod called redis-storage with image: redis:alpine with a Volume of type emptyDir that lasts for the life of the Pod.


Specs on the below.

Pod named 'redis-storage' created

Pod 'redis-storage' uses Volume type of emptyDir

Pod 'redis-storage' uses volumeMount with mountPath = /data/redis


```
k run redis-storage --image=redis:alpine --dry-run=client -o yaml > redis-storage.yaml
```

```redis-storage.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: redis-storage
  name: redis-storage
spec:
  containers:
  - image: redis:alpine
    name: redis-storage
    volumeMounts:
    - mountPath: /data/redis
      name: redis-storage
  volumes:
  - name: redis-storage
    emptyDir: {}
```

## Q3
Create a new pod called super-user-pod with image busybox:1.28. Allow the pod to be able to set system_time.


The container should sleep for 4800 seconds.

Pod: super-user-pod

Container Image: busybox:1.28

Is SYS_TIME capability set for the container?


```
k run super-user-pod --image=busybox:1.28 --command "sleep 4800" --dry-run=client -o yaml > super-user-pod.yaml
```

```super-user-pod.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: super-user-pod
  name: super-user-pod
spec:
  containers:
  - command:
    - "sh"
    - "-c"
    - "sleep 4800"
    image: busybox:1.28
    name: super-user-pod
    securityContext:
      capabilities:
        add:
          - "SYS_TIME"
```

## Q4
A pod definition file is created at /root/CKA/use-pv.yaml. Make use of this manifest file and mount the persistent volume called pv-1. Ensure the pod is running and the PV is bound.


mountPath: /data

persistentVolumeClaim Name: my-pvc

persistentVolume Claim configured correctly

pod using the correct mountPath

pod using the persistent volume claim?
```use-pv.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: use-pv
  name: use-pv
spec:
  volumes:
    - name: my-pvc
      persistentVolumeClaim:
        claimName: my-pvc
  containers:
  - image: nginx
    name: use-pv
    resources: {}
    volumeMounts:
    - mountPath: "/data"
      name: my-pvc
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}
```

```pv-1.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  creationTimestamp: "2025-01-09T16:34:10Z"
  finalizers:
  - kubernetes.io/pv-protection
  name: pv-1
  resourceVersion: "2620"
  uid: 4ab5758f-2d8b-482a-a061-304ebf1759a2
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 10Mi
  hostPath:
    path: /opt/data
    type: ""
  persistentVolumeReclaimPolicy: Retain
  volumeMode: Filesystem
status:
  lastPhaseTransitionTime: "2025-01-09T16:34:10Z"
  phase: Available
```

```my-pvc.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Mi
```


## Q5
Create a new deployment called nginx-deploy, with image nginx:1.16 and 1 replica. Next upgrade the deployment to version 1.17 using rolling update.


Deployment : nginx-deploy. Image: nginx:1.16

Image: nginx:1.16

Task: Upgrade the version of the deployment to 1:17

Task: Record the changes for the image upgrade


```
k create deploy nginx-deploy --image=nginx:1.16 --replicas=1
k edit deploy nginx-deploy
```

## Q6
Create a new user called john. Grant him access to the cluster. John should have permission to create, list, get, update and delete pods in the development namespace . The private key exists in the location: /root/CKA/john.key and csr at /root/CKA/john.csr.


Important Note: As of kubernetes 1.19, the CertificateSigningRequest object expects a signerName.

Please refer the documentation to see an example. The documentation tab is available at the top right of terminal.

CSR: john-developer Status:Approved

Role Name: developer, namespace: development, Resource: Pods

Access: User 'john' has appropriate permissions

```
cat /root/CKA/john.csr | base64 -w 0
```


```
---john-developer.yaml
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: john-developer
spec:
  signerName: kubernetes.io/kube-apiserver-client
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0tLS0KTUlJQ1ZEQ0NBVHdDQVFBd0R6RU5NQXNHQTFVRUF3d0VhbTlvYmpDQ0FTSXdEUVlKS29aSWh2Y05BUUVCQlFBRApnZ0VQQURDQ0FRb0NnZ0VCQUt2Um1tQ0h2ZjBrTHNldlF3aWVKSzcrVVdRck04ZGtkdzkyYUJTdG1uUVNhMGFPCjV3c3cwbVZyNkNjcEJFRmVreHk5NUVydkgyTHhqQTNiSHVsTVVub2ZkUU9rbjYra1NNY2o3TzdWYlBld2k2OEIKa3JoM2prRFNuZGFvV1NPWXBKOFg1WUZ5c2ZvNUpxby82YU92czFGcEc3bm5SMG1JYWpySTlNVVFEdTVncGw4bgpjakY0TG4vQ3NEb3o3QXNadEgwcVpwc0dXYVpURTBKOWNrQmswZWhiV2tMeDJUK3pEYzlmaDVIMjZsSE4zbHM4CktiSlRuSnY3WDFsNndCeTN5WUFUSXRNclpUR28wZ2c1QS9uREZ4SXdHcXNlMTdLZDRaa1k3RDJIZ3R4UytkMEMKMTNBeHNVdzQyWVZ6ZzhkYXJzVGRMZzcxQ2NaanRxdS9YSmlyQmxVQ0F3RUFBYUFBTUEwR0NTcUdTSWIzRFFFQgpDd1VBQTRJQkFRQ1VKTnNMelBKczB2czlGTTVpUzJ0akMyaVYvdXptcmwxTGNUTStsbXpSODNsS09uL0NoMTZlClNLNHplRlFtbGF0c0hCOGZBU2ZhQnRaOUJ2UnVlMUZnbHk1b2VuTk5LaW9FMnc3TUx1a0oyODBWRWFxUjN2SSsKNzRiNnduNkhYclJsYVhaM25VMTFQVTlsT3RBSGxQeDNYVWpCVk5QaGhlUlBmR3p3TTRselZuQW5mNm96bEtxSgpvT3RORStlZ2FYWDdvc3BvZmdWZWVqc25Yd0RjZ05pSFFTbDgzSkljUCtjOVBHMDJtNyt0NmpJU3VoRllTVjZtCmlqblNucHBKZWhFUGxPMkFNcmJzU0VpaFB1N294Wm9iZDFtdWF4bWtVa0NoSzZLeGV0RjVEdWhRMi80NEMvSDIKOWk1bnpMMlRST3RndGRJZjAveUF5N05COHlOY3FPR0QKLS0tLS1FTkQgQ0VSVElGSUNBVEUgUkVRVUVTVC0tLS0tCg==
  usages:
  - digital signature
  - key encipherment
  - client auth
```

```
kubectl get certificatesigningrequest.certificates.k8s.io/john-developer

kubectl certificate approve john-developer

kubectl get certificatesigningrequest.certificates.k8s.io/john-developer

kubectl create role developer --resource=pods --verb=create,list,get,update,delete --namespace=development

kubectl create rolebinding developer-role-binding --role=developer --user=john --namespace=development

kubectl get role developer --namespace=development

kubectl get rolebinding developer-role-binding --namespace=development

kubectl auth can-i update pods --as=john --namespace=development
```

```
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer
  namespace: development
rules:
- apiGroups:
  - ""
  resourceNames:
  - "*"
  resources:
  - pods
  verbs:
  - get
  - create
  - list
  - update
  - delete
```

```
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: john-role-binding
  namespace: development
roleRef:
  apiGroup: rbac.authorization.k8s.io
  kind: Role
  name: developer
subjects:
- apiGroup: rbac.authorization.k8s.io
  kind: User
  name: john
```

## Q7
Create a nginx pod called nginx-resolver using image nginx, expose it internally with a service called nginx-resolver-service. Test that you are able to look up the service and pod names from within the cluster. Use the image: busybox:1.28 for dns lookup. Record results in /root/CKA/nginx.svc and /root/CKA/nginx.pod


Pod: nginx-resolver created

Service DNS Resolution recorded correctly

Pod DNS resolution recorded correctly


```
k run nginx-resolver --image=nginx --port=80
k expose pod nginx-resolver --name nginx-resolver-service --port=80 --target-port=80

k run busybox --image=busybox:1.28 --command "sleep 5000" --dry-run=client -o yaml > busybox.yaml


kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup nginx-resolver-service > /root/CKA/nginx.svc

# Get the IP of the nginx-resolver pod and replace the dots(.) with hyphon(-) which will be used below.
kubectl get pod nginx-resolver -o wide
kubectl run test-nslookup --image=busybox:1.28 --rm -it --restart=Never -- nslookup <P-O-D-I-P.default.pod> > /root/CKA/nginx.pod

cat /root/CKA/nginx.svc
cat /root/CKA/nginx.pod
```

## Q8
Create a static pod on node01 called nginx-critical with image nginx and make sure that it is recreated/restarted automatically in case of a failure.


Use /etc/kubernetes/manifests as the Static Pod path for example.

static pod configured under /etc/kubernetes/manifests ?

Pod nginx-critical-node01 is up and running



```nginx-critical.yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx-critical
spec:
  containers:
  - image: nginx
    name: nginx
```