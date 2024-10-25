# lightning-lab-2_1

```
k get pods -A

NAMESPACE     NAME                                   READY   STATUS    RESTARTS      AGE
default       dev-pod-dind-878516                    3/3     Running   0             37s
default       pod-xyz1123                            1/1     Running   0             37s
default       webapp-color                           1/1     Running   0             36s
dev0403       nginx0403                              1/1     Running   0             37s
dev0403       pod-dar85                              1/1     Running   0             37s
dev1401       nginx1401                              0/1     Running   0             37s
dev1401       pod-kab87                              1/1     Running   0             37s
dev2406       nginx2406                              1/1     Running   0             37s
dev2406       pod-var2016                            1/1     Running   0             37s
e-commerce    e-com-1123                             1/1     Running   0             36s
kube-system   coredns-768b85b76f-27vtp               1/1     Running   0             29m
kube-system   coredns-768b85b76f-m2xmn               1/1     Running   0             29m
kube-system   etcd-controlplane                      1/1     Running   0             29m
kube-system   kube-apiserver-controlplane            1/1     Running   0             29m
kube-system   kube-controller-manager-controlplane   1/1     Running   0             29m
kube-system   kube-proxy-2glhs                       1/1     Running   0             29m
kube-system   kube-proxy-pmz89                       1/1     Running   0             28m
kube-system   kube-scheduler-controlplane            1/1     Running   0             29m
kube-system   weave-net-4hdbd                        2/2     Running   0             28m
kube-system   weave-net-pf7xp                        2/2     Running   1 (29m ago)   29m
marketing     redis-69cdff9f8-brp77                  1/1     Running   0             36s
```

```
k describe pod nginx1401 -n dev1401
Name:             nginx1401
Namespace:        dev1401
Priority:         0
Service Account:  default
Node:             node01/192.24.75.12
Start Time:       Wed, 17 Jul 2024 11:25:14 +0000
Labels:           run=nginx
Annotations:      <none>
Status:           Running
IP:               10.244.192.1
IPs:
  IP:  10.244.192.1
Containers:
  nginx:
    Container ID:   containerd://f556a244bd846f062aed8ea98445a280f19f22ce6f515caff7f1fd6d81093f54
    Image:          kodekloud/nginx
    Image ID:       docker.io/kodekloud/nginx@sha256:2862900861517dfaf9e0ed0f4fa199744a7410f4f78520866031c725c386bb5e
    Port:           9080/TCP
    Host Port:      0/TCP
    State:          Running
      Started:      Wed, 17 Jul 2024 11:25:26 +0000
    Ready:          False
    Restart Count:  0
    Readiness:      http-get http://:8080/ delay=0s timeout=1s period=10s #success=1 #failure=3
    Environment:    <none>
    Mounts:
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-6s4vg (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True
  Initialized                 True
  Ready                       False
  ContainersReady             False
  PodScheduled                True
Volumes:
  kube-api-access-6s4vg:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type     Reason     Age                  From               Message
  ----     ------     ----                 ----               -------
  Normal   Scheduled  2m38s                default-scheduler  Successfully assigned dev1401/nginx1401 to node01
  Normal   Pulling    2m34s                kubelet            Pulling image "kodekloud/nginx"
  Normal   Pulled     2m27s                kubelet            Successfully pulled image "kodekloud/nginx" in 321ms (6.895s including waiting). Image size: 50986074 bytes.
  Normal   Created    2m27s                kubelet            Created container nginx
  Normal   Started    2m26s                kubelet            Started container nginx
  Warning  Unhealthy  8s (x17 over 2m26s)  kubelet            Readiness probe failed: Get "http://10.244.192.1:8080/": dial tcp 10.244.192.1:8080: connect: connection refused

```

```nginx1401.yaml
apiVersion: v1
kind: Pod
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"Pod","metadata":{"annotations":{},"creationTimestamp":null,"labels":{"run":"nginx"},"name":"nginx1401","namespace":"dev1401"},"spec":{"containers":[{"image":"kodekloud/nginx","imagePullPolicy":"IfNotPresent","name":"nginx","ports":[{"containerPort":9080}],"readinessProbe":{"httpGet":{"path":"/","port":8080}},"resources":{}}],"dnsPolicy":"ClusterFirst","restartPolicy":"OnFailure"},"status":{}}
  creationTimestamp: "2024-07-17T11:25:14Z"
  labels:
    run: nginx
  name: nginx1401
  namespace: dev1401
  resourceVersion: "3050"
  uid: 1b40182b-e284-44d3-a63f-2fd75ec9af35
spec:
  containers:
  - image: kodekloud/nginx
    imagePullPolicy: IfNotPresent
    name: nginx
    ports:
    - containerPort: 9080
      protocol: TCP
    readinessProbe:
      failureThreshold: 3
      httpGet:
        path: /
        port: 9080
        scheme: HTTP
      periodSeconds: 10
      successThreshold: 1
      timeoutSeconds: 1
    livenessProbe:
      exec:
        command:
          - ls
          - /var/www/html/file_check
      initialDelaySeconds: 10
      periodSeconds: 60
    resources: {}
    terminationMessagePath: /dev/termination-log
    terminationMessagePolicy: File
    volumeMounts:
    - mountPath: /var/run/secrets/kubernetes.io/serviceaccount
      name: kube-api-access-6s4vg
      readOnly: true
  dnsPolicy: ClusterFirst
  enableServiceLinks: true
  nodeName: node01
  preemptionPolicy: PreemptLowerPriority
  priority: 0
  restartPolicy: OnFailure
  schedulerName: default-scheduler
  securityContext: {}
  serviceAccount: default
  serviceAccountName: default
  terminationGracePeriodSeconds: 30
  tolerations:
  - effect: NoExecute
    key: node.kubernetes.io/not-ready
    operator: Exists
    tolerationSeconds: 300
  - effect: NoExecute
    key: node.kubernetes.io/unreachable
    operator: Exists
    tolerationSeconds: 300
  volumes:
  - name: kube-api-access-6s4vg
    projected:
      defaultMode: 420
      sources:
      - serviceAccountToken:
          expirationSeconds: 3607
          path: token
      - configMap:
          items:
          - key: ca.crt
            path: ca.crt
          name: kube-root-ca.crt
      - downwardAPI:
          items:
          - fieldRef:
              apiVersion: v1
              fieldPath: metadata.namespace
            path: namespace
status:
  conditions:
  - lastProbeTime: null
    lastTransitionTime: "2024-07-17T11:25:26Z"
    status: "True"
    type: PodReadyToStartContainers
  - lastProbeTime: null
    lastTransitionTime: "2024-07-17T11:25:14Z"
    status: "True"
    type: Initialized
  - lastProbeTime: null
    lastTransitionTime: "2024-07-17T11:25:14Z"
    message: 'containers with unready status: [nginx]'
    reason: ContainersNotReady
    status: "False"
    type: Ready
  - lastProbeTime: null
    lastTransitionTime: "2024-07-17T11:25:14Z"
    message: 'containers with unready status: [nginx]'
    reason: ContainersNotReady
    status: "False"
    type: ContainersReady
  - lastProbeTime: null
    lastTransitionTime: "2024-07-17T11:25:14Z"
    status: "True"
    type: PodScheduled
  containerStatuses:
  - containerID: containerd://f556a244bd846f062aed8ea98445a280f19f22ce6f515caff7f1fd6d81093f54
    image: docker.io/kodekloud/nginx:latest
    imageID: docker.io/kodekloud/nginx@sha256:2862900861517dfaf9e0ed0f4fa199744a7410f4f78520866031c725c386bb5e
    lastState: {}
    name: nginx
    ready: false
    restartCount: 0
    started: true
    state:
      running:
        startedAt: "2024-07-17T11:25:26Z"
  hostIP: 192.24.75.12
  hostIPs:
  - ip: 192.24.75.12
  phase: Running
  podIP: 10.244.192.1
  podIPs:
  - ip: 10.244.192.1
  qosClass: BestEffort
  startTime: "2024-07-17T11:25:14Z"
```

```
k apply -f nginx1401.yaml
kubectl replace -f nginx1401.yaml --force
```
