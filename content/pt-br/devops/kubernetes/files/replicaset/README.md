```
kubectl create -f replication-controller.yaml

kubectl get replicaset

kubectl delete replicaset myapp-replication-controller

kubectl replace -f replication-controller.yaml

kubectl scale --replicas=6 -f replication-controller.yaml

kubectl scale --replicas=6 replicaset myapp-replication-controller
```