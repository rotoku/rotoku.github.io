# Lightning Lab - 1

## 1
Create a Persistent Volume called log-volume. It should make use of a storage class name manual. It should use RWX as the access mode and have a size of 1Gi. The volume should use the hostPath /opt/volume/nginx

```log-volume.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: log-volume
spec:
  capacity:
    storage: 1Gi
  accessModes:
    - ReadWriteMany
  storageClassName: manual
  hostPath:
    path: "/opt/volume/nginx"
```

Next, create a PVC called log-claim requesting a minimum of 200Mi of storage. This PVC should bind to log-volume.
```log-claim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: log-claim
spec:
  storageClassName: manual
  accessModes:
    - ReadWriteMany
  resources:
    requests:
      storage: 200Mi
```

Mount this in a pod called logger at the location /var/www/nginx. This pod should use the image nginx:alpine.
```logger.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: logger
  name: logger
spec:
  volumes:
    - name: task-pv-storage
      persistentVolumeClaim:
        claimName: log-claim
  containers:
  - image: nginx:alpine
    name: logger
    volumeMounts:
    - mountPath: "/var/www/nginx"
      name: task-pv-storage
```

## 2
We have deployed a new pod called secure-pod and a service called secure-service. Incoming or Outgoing connections to this pod are not working.
Troubleshoot why this is happening.

Make sure that incoming connection from the pod webapp-color are successful.


Important: Don't delete any current objects deployed.

Important: Don't Alter Existing Objects!

Connectivity working?
```
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: access-nginx
spec:
  podSelector:
    matchLabels:
      run: secure-pod        
  ingress:
  - ports:
    - protocol: TCP
      port: 80 
```

## 3
Create a pod called time-check in the dvl1987 namespace. This pod should run a container called time-check that uses the busybox image.

Create a config map called time-config with the data TIME_FREQ=10 in the same namespace.
The time-check container should run the command: while true; do date; sleep $TIME_FREQ;done and write the result to the location /opt/time/time-check.log.
The path /opt/time on the pod should mount a volume that lasts the lifetime of this pod.

Pod time-check configured correctly?


```
k create ns dvl1987
k create cm time-config --from-literal=TIME_FREQ=10 -n dvl1987
k run time-check -n dvl1987 --image=busybox --dry-run=client -o yaml > time-check.yaml
```

```time-check.yaml
apiVersion: v1
kind: Pod
metadata:
  labels:
    run: time-check
  name: time-check
  namespace: dvl1987
spec:
  volumes:
  - name: empty-dir-volume
    emptyDir: {}
  containers:
  - image: busybox
    name: time-check
    env:
    - name: "TIME_FREQ"
      valueFrom:
        configMapKeyRef:
          key: "TIME_FREQ"
          name: "time-config"
    command:
    - "sh"
    - "-c"
    - "while true; do date >> /opt/time/time-check.log; sleep $TIME_FREQ;done"
    volumeMounts:
    - mountPath: /opt/time
      name: empty-dir-volume
```

## 4
Create a new deployment called nginx-deploy, with one single container called nginx, image nginx:1.16 and 4 replicas.
The deployment should use RollingUpdate strategy with maxSurge=1, and maxUnavailable=2.

Next upgrade the deployment to version 1.17.

Finally, once all pods are updated, undo the update and go back to the previous version.


Deployment created correctly?

Was the deployment created with nginx:1.16?

Was it upgraded to 1.17?

Deployment rolled back to 1.16?


```
k create deploy nginx-deploy --image=nginx:1.16 --replicas=4 --dry-run=client -o yaml > nginx-deploy.yaml
```

```nginx-deploy.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  labels:
    app: nginx-deploy
  name: nginx-deploy
spec:
  replicas: 4
  selector:
    matchLabels:
      app: nginx-deploy
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 2
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nginx-deploy
    spec:
      containers:
      - image: nginx:1.16
        name: nginx
```

```
k set image deploy nginx-deploy nginx=nginx:1.17
```

```
kubectl rollout undo deployment/nginx-deploy
```

## 5
Create a redis deployment with the following parameters:

Name of the deployment should be redis using the redis:alpine image. It should have exactly 1 replica.

The container should request for .2 CPU. It should use the label app=redis.

It should mount exactly 2 volumes.

a. An Empty directory volume called data at path /redis-master-data.

b. A configmap volume called redis-config at path /redis-master.

c. The container should expose the port 6379.


The configmap has already been created.


```
apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: redis
  name: redis
spec:
  replicas: 1
  selector:
    matchLabels:
      app: redis
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: redis
    spec:
      containers:
      - image: redis:alpine
        name: redis
        ports:
        - containerPort: 6379
        resources: 
          requests:
            cpu: 0.2
        volumeMounts:
        - mountPath: /redis-master-data
          name: data
        - name: redis-config
          mountPath: "/redis-master"
          readOnly: true          
      volumes:
      - name: data
        emptyDir: {}
      - name: redis-config
        configMap:
          name: redis-config         
status: {}
```