# Application Lifecycle Management

## Deplayment Strategy
- Recreate
- RollingUpdate (Default)

## Summary Commands
```
### Create
kubectl create –f deployment-definition.yml

### Get
kubectl get deployments

### Update
kubectl apply –f deployment-definition.yml
kubectl set image deployment/myapp-deployment nginx=nginx:1.9.1

### Status
kubectl rollout status deployment/myapp-deployment
kubectl rollout status deployment/metrics-server -n kube-system
kubectl rollout history deployment/myapp-deployment
kubectl rollout history deployment/metrics-server -n kube-system


### Rollback
kubectl rollout undo deployment/myapp-deployment
```

## Commands and Arguments
```
FROM Ubuntu

ENTRYPOINT ["sleep", "5"]
```

```
FROM Ubuntu

ENTRYPOINT ["sleep"]
```

```
FROM Ubuntu

ENTRYPOINT ["sleep"]

CMD ["5"]
```

```rewritter entrypoint
docker run --entrypoint sleep2.0 ubuntu-sleepr 10
```


## Encrypting Secret Data at Rest
```
apt update -y && apt install -y etcd-client bsdmainutils

ETCDCTL_API=3 etcdctl \
    --cacert=/etc/kubernetes/pki/etcd/ca.crt \
    --cert=/etc/kubernetes/pki/etcd/server.crt \
    --key=/etc/kubernetes/pki/etcd/server.key \
    get /registry/secrets/default/my-secrets | hexdump -C
```    