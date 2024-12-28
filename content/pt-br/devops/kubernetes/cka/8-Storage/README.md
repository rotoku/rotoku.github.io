# Storage

## Storage in Docker
- File system
    - /var/lib/docker
        - buildkit
        - containers
        - engine-id
        - image
        - network
        - overlay2
        - plugins
        - runtimes
        - swarm
        - tmp
        - volumes

## Docker Storage Drivers
- AUFS
- ZFS
- BTRFS
- Device Mapper
- overlay
- overlay2

## Volume Driver Plugins in Docker
- Local
- Azure File Storage
- Convoy
- DigitalOcean Block Storage
- Flocker

## Container Storage Interface
- Container Storage Interface
    - portworx
    - amazon ebs
    - dell emc
- Should call to provision a new volume
- Should call to delete a volume
- Should call to place a workload that uses the volume onto a node

## PersistentVolume (static Provisioning)
- volumes:
    - hostPath (volume criado em cada node)
    - awsElasticBlockStore

## PersistentVolumeClaim
- binding:
    - sufficient capacity
    - access modes
    - volume modes
    - storage class
    - selector

## Storage Class (Dynamic Provisioning)
```google-storage.yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: google-storage
provisioner: kubernetes.io/gce-pd
```

```myclaim.yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: myclaim
spec:
  accessModes:
    - ReadWriteOnce
  storageClassName: google-storage
  resources:
    requests:
      storage: 500Mi        
```

```mypod.yaml
apiVersion: v1
kind: Pod
metadata:
  name: mypod
spec:
  containers:
  - name: myfrontend
    image: nginx
    volumeMounts:
    - mountPath: "/var/www/html"
      name: mypd
  volumes:
  - name: mypd
    persistentVolumeClaim:
      claimName: myclaim
```

## Configure Applications with Persistent Storage

## Access Modes for Volumes

## Kubernetes Storage Object