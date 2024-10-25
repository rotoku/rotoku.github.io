# lightning-lab-1_4

## Deployment

```nginx-deploy.yaml
kubectl create deploy nginx-deploy \
    --image=nginx:1.16 \
    --replicas=4 \
    --dry-run=client \
    -o yaml > nginx-deploy.yaml
```

```
.
.
.
  strategy:
    rollingUpdate:
      maxSurge: 1
      maxUnavailable: 2
.
.
.
```

```bash
kubectl set image deployment nginx-deploy nginx=nginx:1.17
```

```bash
kubectl rollout undo deployment nginx-deploy
```
