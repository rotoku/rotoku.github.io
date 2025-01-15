# Other Topics

## YAML

O YAML (acrónimo de "YAML Ain't Markup Language") é um formato de serialização (codificação de dados) de dados legíveis por humanos inspirado em linguagens computacionais (programação e marcação), proposto por Clark Evans em 2001.

Como é usado frequentemente XML para serialização de dados e XML é uma autêntica linguagem de marcação de documentos, é razoável considerar o YAML como uma linguagem de marcação rápida.

## Key Value Pai
```example001.yaml
Fruit: Apple
Vegetable: Carrot
Liquid: Water
Meat: Chicken
```

## Array/Lists
```example002.yaml
Fruits:
- Apple
- Orange
- Banana

Vegetables:
- Carrot
- Tomato
- Lettuce
```

## Dictionary/Map
```example003.yaml
Banana:
  Calories: 105
  Fat: 0.4 g
  Carbs: 27 g
```

## Dictionary/Map
```example003.yaml
Fruits:
  - Banana:
      Calories: 105
      Fat: 0.4 g
      Carbs: 27 g
  - Orange:
      Calories: 105
      Fat: 0.4 g
      Carbs: 27 g      
```

## JsonPath

```data.json
[
  12,43,23,12,56,43,93,32,45,63,27,8,78
]
```

```
k get pods -o jsonpath="{$.items[0].spec.containers[1].name}"
k get pods -o jsonpath="{$.items[0].spec.containers[?(@.image == 'nginx')].name}"
k get pods -o jsonpath="{$.items[0].status.qosClass}"


@ < 40
@ > 40
@ == 40
@ != 40
@ in [40,43,45]
@ nin [40,43,45]


cat q1.json | jpath $.property1

cat q13.json | jpath '$[0,3]'
```


```vehicles.json
{
    "car": {
        "color": "blue",
        "price": 20000
    },
    "bus": {
        "color": "white",
        "price": 120000
    }
}
```

```
$.car.color = blue

$.bus.color = white

$.*.color = ["blue", "white"]

$.*.price = [20000, 120000]

cat q9.json | jpath '$.prizes[?(@.year == 2014)].laureates[*].firstname'

$[0:3] == range 0 to 3

$[0:8:2] == de 2 em 2

$[-1] == last item

$[-1:0]

$[-3:] == last 3 elements
```

## Loops - Range
```
k run nginx --image=nginx
k get pods nginx -o jsonpath='{.metadata.name}{"\n"}{.spec.containers[*].name}';echo

k get nodes -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.status.capacity.cpu}{"\n"}{end}'
```

## Custom Columns
```
k get nodes -o custom-columns=NODE:.metadata.name

k get nodes -o custom-columns=NODE:.metadata.name,CPU:.status.capacity.cpu
```

## Sort
```
k get pods -n kube-system

NAME                               READY   STATUS    RESTARTS        AGE
coredns-7c65d6cfc9-j47jz           1/1     Running   0               25h
coredns-7c65d6cfc9-pqdh2           1/1     Running   0               25h
etcd-plankton                      1/1     Running   4               25h
kube-apiserver-plankton            1/1     Running   3               25h
kube-controller-manager-plankton   1/1     Running   7 (3h40m ago)   25h
kube-proxy-5cc6b                   1/1     Running   0               25h
kube-scheduler-plankton            1/1     Running   6 (3h41m ago)   25h
weave-net-jxksq                    2/2     Running   0               25h


k get pods -n kube-system --sort-by=.metadata.creationTimestamp
NAME                               READY   STATUS    RESTARTS        AGE
etcd-plankton                      1/1     Running   4               25h
kube-apiserver-plankton            1/1     Running   3               25h
kube-controller-manager-plankton   1/1     Running   7 (3h42m ago)   25h
kube-scheduler-plankton            1/1     Running   6 (3h43m ago)   25h
kube-proxy-5cc6b                   1/1     Running   0               25h
coredns-7c65d6cfc9-j47jz           1/1     Running   0               25h
coredns-7c65d6cfc9-pqdh2           1/1     Running   0               25h
weave-net-jxksq                    2/2     Running   0               25h
```