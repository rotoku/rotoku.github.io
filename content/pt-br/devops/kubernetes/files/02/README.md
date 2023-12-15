# DAY 02

```
## Obter detalhes sobre o pod
kubectl describe pods nginx

kubectl get pods nginx -o yaml

## attach e exec
kubectl run strigus --image nginx --port 80
kubectl run girus -it --image alpine
$ apk add curl
$ curl 10.244.3.2

kubectl attach girus -c girus -it

kubectl exec -it strigus -- bash


kubectl create deployment hello-world --image=k8s.gcr.io/echoserver:1.10

kubectl get deployments

kubectl expose deployment hello-world --type=NodePort --port=8080


kubectl delete services hello-world
kubectl delete deployment hello-world

kubectl run nginx --image nginx --dry-run=client -o yaml

## utilizado na primeira vez
kubectl create -f pod.yml
## utilizado na primeira vez e/ou para atualização
kubectl apply -f pod.yml

kubectl logs girus -f

kubectl logs girus -c apache

kubectl get pods -w

## Limite de utilização de CPU e Memória
pod-limitado.yml
```