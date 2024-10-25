# lightning-lab-2_3

```
k get ns dev2406
k create ns dev2406

kubectl run my-busybox \
    --image=busybox \
    --dry-run=client \
    -o yaml > my-busybox.yaml
```
