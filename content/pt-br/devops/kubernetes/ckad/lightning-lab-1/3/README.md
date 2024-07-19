# lightning-lab-1_3

```bash
kubectl get ns dvl1987
kubectl create ns dvl1987

kubectl create configmap time-config \
    -n dvl1987 \
    --from-literal=TIME_FREQ=10


kubectl run time-check \
    --image=busybox \
    --dry-run=client \
    -o yaml > time-check.yaml
```

## Pod

```time-check.yaml
apiVersion: v1
kind: Pod
metadata:
  creationTimestamp: null
  labels:
    run: time-check
  name: time-check
  namespace: dvl1987
spec:
  volumes:
    - name: log-volume
      emptyDir: {}
  containers:
  - image: busybox
    name: time-check
    volumeMounts:
      - mountPath: /opt/time
        name: log-volume
    command: ["/bin/sh", "-c", "while true; do date; sleep $TIME_FREQ; done >> /opt/time/time-check.log"]
    env:
      - name: TIME_FREQ
        valueFrom:
          configMapKeyRef:
            name: time-config
            key: TIME_FREQ
    resources: {}
  dnsPolicy: ClusterFirst
  restartPolicy: Always
status: {}

```
