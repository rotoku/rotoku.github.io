```
kubectl create deployment --image nginx --replicas 3 nginx-deployment

kubectl describe deployment nginx-deployment

kubectl create deployment --image nginx --replicas 3 nginx-deployment --dry-run=client -o yaml > deployment.yaml

kubectl delete deployment nginx-deployment

kubectl create namespace giropops --dry-run=client -o yaml

Estrategias de deploy nativas
- Rolling updates 25% de indisponibilidade e de criação
    MaxSurge: 1
    MaxUnavailable: 2
    Dado que tenhamos 10 pods nesta estratégia o funcionamento é o seguinte o k8s vai deixar:
    Surge 1: pode ter até 1 pod a mais do que esta definido no max replicas ou seja 11 pods
    Unavailable 2: vai atualizar de 2 em 2, então no caso de 10 pod ou ainda irá continuar no ar enquanto esta atualizando

- Recreate

kubectl rollout status deployment -n giropops nginx-deployment    


## Como fazer o rollback
kubectl rollout undo deployment -n giropops nginx-deployment

kubectl rollout undo deployment -n giropops nginx-deployment --revision 6

kubectl rollout history deployment -n giropops nginx-deployment

## Pausa o deployment
kubectl rollout pause deployment -n giropops nginx-deployment

## Volta o deployment, quando o mesmo esta pausado
kubectl rollout resume deployment -n giropops nginx-deployment

## Restart do deployment
kubectl rollout restart deployment -n giropops nginx-deployment

kubectl scale deployment -n giropops --replicas 5 nginx-deployment

kubectl set image deployment nginx-deployment nginx=nginx:1.9.1 -n giropops

## Replication Controller (old) vs Replica Set (new)

kubectl create -f replicaset-definition.yaml
kubectl get replicaset
kubectl delete replicaset
kubectl replace replicaset update-replicaset-definition.yaml
kubectl scale --replicas=6 -f replicaset-definition.yaml
```