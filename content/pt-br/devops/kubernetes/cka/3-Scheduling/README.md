# Scheduling

## Node Name
```
apiVersion: v1
kind: Pod
metadata:
  name: meu-pod
spec:
  nodeName: node001
  containers:
  - name: nginx
    image: nginx
    ports:
    - containerPort: 80

```

## Labels and Selectors
Labels e Selectors são conceitos fundamentais no kubernetes usados para organizar e selecionar recursos.

- Labels: são pares chave-valor que são anexados a objetos, como pods, services e etc. Eles são usados para identificar e agrupar objetos de maneira significativa e arbitrária. Por exemplo, você pode adicionar uma label app=frontenda todos os pods que fazem parte do frontend da sua aplicação.

- Selectors: São usados para selecionar um subconjunto de objetos com base nos seus labels. Existem 2 tipos principais de selectors:
    - Equality-based selectors: Selecionam objetos que possuem uma label com um valor especifico. Exemplo: app=frontend
    - Set-based selectors: Selecionam objetos com base em uma lista de valores. Exemplo: environment in (production, staging)

## Annotations
```
```

## Taints - Node
```
kubectl taint nodes node-name key=value:taint-effect

# taint-effect: NoSchedule | PreferNoSchedule | NoExecute

kubectl taint nodes node1 app=blue:NoSchedule
```

```
spec:
  tolerations:
  - key: "app"
    operator: "Equal"
    value: "blue"
    effect: "NoSchedule"
```

```
## Remove Taint from ControlPlane
kubectl taint nodes controlplane node-role.kubernetes.io/control-plane:NoSchedule-
```
### Links
- https://stackoverflow.com/questions/28857993/how-does-kubernetes-scheduler-work
- https://jvns.ca/blog/2017/07/27/how-does-the-kubernetes-scheduler-work/
- https://kubernetes.io/blog/2017/03/advanced-scheduling-in-kubernetes/
- https://github.com/kubernetes/community/blob/master/contributors/devel/sig-scheduling/scheduling_code_hierarchy_overview.md


- https://stackoverflow.com/questions/28857993/how-does-kubernetes-scheduler-work
- https://jvns.ca/blog/2017/07/27/how-does-the-kubernetes-scheduler-work/
- https://kubernetes.io/blog/2017/03/advanced-scheduling-in-kubernetes/
- https://github.com/kubernetes/community/blob/master/contributors/devel/sig-scheduling/scheduling_code_hierarchy_overview.md