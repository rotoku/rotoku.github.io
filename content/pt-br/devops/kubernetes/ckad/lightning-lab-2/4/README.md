# lightning-lab-2_4

```ingress-vh-routing.yaml
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: ingress-vh-routing
  annotations:
    nginx.ingress.kubernetes.io/rewrite-target: /
spec:
  ingressClassName: nginx-example
  rules:
    - host: watch.ecom-store.com
      http:
        paths:
          - pathType: Prefix
            path: "/video"
            backend:
              service:
                name: video-service
                port:
                  number: 8080
    - host: apparels.ecom-store.com
      http:
        paths:
          - pathType: Prefix
            path: "/wear"
            backend:
              service:
                name: apparels-service
                port:
                  number: 8080
```
