# lightning-lab-1_1

## PersistentVolume

```log-volume.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: log-volume
spec:
  storageClassName: manual
  accessModes:
    - "ReadWriteMany"
  capacity:
    storage: 1Gi
  hostPath:
    path: /opt/volume/nginx
```

## PersistentVolumeClaim

```log-claim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: log-claim
spec:
  storageClassName: manual
  accessModes:
    - "ReadWriteMany"
  resources:
    requests:
      storage: 200Mi
```

## Pod

```logger.yaml
apiVersion: v1
kind: Pod
metadata:
  name: logger
  labels:
    name: logger
spec:
  containers:
    - name: logger
      image: nginx:alpine
      volumeMounts:
        - mountPath: /var/www/nginx
          name: log
  volumes:
    - name: log
      persistentVolumeClaim:
        claimName: log-claim
```
