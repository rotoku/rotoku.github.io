# DAY 06

## StorageClass
```
Provisioners para cada storage provider:
- ebs.csi.aws.com (aws ebs)
- k8s.io/minikube-hostpath (minikube)[diretório no node e compartilhado para a pod]
- rancher.io/local-path (kind)
```

## EmptyDir
```
```

## PersistentVolume
```
kubectl get pv
kubectl get persistentvolume


### nfs
sudo mkdir -p /mnt/nfs
sudo chown -R rkumabe:rkumabe /mnt/nfs
sudo apt-get update -y && sudo apt-get install -y nfs-kernel-server nfs-common
sudo vim /etc/exports
# /etc/exports: the access control list for filesystems which may be exported
#               to NFS clients.  See exports(5).
#
# Example for NFSv2 and NFSv3:
# /srv/homes       hostname1(rw,sync,no_subtree_check) hostname2(ro,sync,no_subtree_check)
#
# Example for NFSv4:
# /srv/nfs4        gss/krb5i(rw,sync,fsid=0,crossmnt,no_subtree_check)
# /srv/nfs4/homes  gss/krb5i(rw,sync,no_subtree_check)
#
/mnt/nfs        *(rw,sync,no_root_squash,no_subtree_check)

-------------------
sudo exportfs -ar
showmount -e


mount -t nfs 192.168.0.20:/mnt/nfs /mnt/nfs
```

## PersistentVolumeClaim
```
```

## ConfigMap
```
```