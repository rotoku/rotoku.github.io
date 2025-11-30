# Mock Exams

## Q1
Deploy a pod named nginx-pod using the nginx:alpine image.


Once done, click on the Next Question button in the top right corner of this panel. You may navigate back and forth freely between all questions. Once done with all questions, click on End Exam. Your work will be validated at the end and score shown. Good Luck!


```
k run nginx-pod --image=nginx:alpine
k get pod nginx-pod
```

## Q2
Deploy a messaging pod using the redis:alpine image with the labels set to tier=msg.

```
k run messaging --image=redis:alpine -l tier=msg
```

## Q3
Create a namespace named apx-x9984574
```
k create ns apx-x9984574
```

## Q4
Get the list of nodes in JSON format and store it in a file at /opt/outputs/nodes-z3444kd9.json.

```
k get nodes -o json > /opt/outputs/nodes-z3444kd9.json
cat /opt/outputs/nodes-z3444kd9.json
```

## Q5
Create a service messaging-service to expose the messaging application within the cluster on port 6379.


Use imperative commands.


```
kubectl expose pod messaging --port=6379 --name messaging-service
```

## Q6
Create a deployment named hr-web-app using the image kodekloud/webapp-color with 2 replicas.


```
k create deploy hr-web-app --image=kodekloud/webapp-color --replicas=2
```

## Q7
Create a static pod named static-busybox on the controlplane node that uses the busybox image and the command sleep 1000.


```
cd /etc/kubernetes/manifests
k run static-busybox --image=busybox --command "sleep 1000" --dry-run=client -o yaml > static-busybox.yaml
```

## Q8
Create a POD in the finance namespace named temp-bus with the image redis:alpine.


```
k run temp-bus --image=redis:alpine -n finance
```

## Q9
A new application orange is deployed. There is something wrong with it. Identify and fix the issue.
```
controlplane /etc/kubernetes/manifests ➜  k get pods orange
NAME     READY   STATUS       RESTARTS      AGE
orange   0/1     Init:Error   2 (21s ago)   24s
```

## Q10
Expose the hr-web-app created in the previous task as a service named hr-web-app-service, accessible on port 30082 on the nodes of the cluster.


The web application listens on port 8080.

```
k create service nodeport hr-web-app-service --tcp=8080:8080 --dry-run=client -o yaml > hr-web-app-service.yaml
```

## Q11
Use JSON PATH query to retrieve the osImages of all the nodes and store it in a file /opt/outputs/nodes_os_x43kj56.txt.


The osImage are under the nodeInfo section under status of each node.


```
k get nodes -o jsonpath='{$.items[*].status.nodeInfo.osImage}' > /opt/outputs/nodes_os_x43kj56.txt
```

## Q12
Create a Persistent Volume with the given specification: -

Volume name: pv-analytics

Storage: 100Mi

Access mode: ReadWriteMany

Host path: /pv/data-analytics


```
apiVersion: v1
kind: PersistentVolume
metadata:
  name: pv-analytics
spec:
  capacity:
    storage: 100Mi
  accessModes:
    - ReadWriteMany
  hostPath:
    path: /pv/data-analytics
```