# GitOps Fundamentals

## O que é GitOps e por que você deve adotá-lo
GitOps é um conjunto de melhores práticas em que todo o processo de entrega de código é controlado via Git, incluindo infraestrutura e definição de aplicativo como código e automação para concluir atualizações e reversões.

Argo CD é apenas um membro da família de projetos Argo . São eles:
- Argo CD (controlador GitOps)
- Argo Rollouts (controlador de entrega progressiva)
- Argo Workflows (mecanismo de fluxo de trabalho para Kubernetes)
- Argo Events (Manipulação de eventos para Kubernetes)

## Como gerenciar aplicativos com o Argo CD
Há várias perguntas que você precisa responder antes de tomar uma decisão sobre a instalação:
- A instalação do seu Argo CD gerenciará apenas o cluster no qual ele está instalado? Ele gerenciará outros clusters? Ambos?
- Você quer uma instalação de Alta Disponibilidade (HA) ou não?
- Você quer usar manifestos simples ou está procurando um gráfico Helm?
- Como você gerenciará as atualizações do Argo CD? Com ​​um sistema externo? Ou você deseja que o Argo CD gerencie a si mesmo?

```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl get secrets argocd-initial-admin-secret -n argocd -o jsonpath='{$.data.password}' | base64 -d; echo

curl -sSL -o /usr/local/bin/argocd https://github.com/argoproj/argo-cd/releases/download/v2.1.5/argocd-linux-amd64
chmod +x /usr/local/bin/argocd
argocd help

argocd login localhost:8080 --insecure
argocd version
argocd app list

https://kubernetes.default.svc


kubectl create service nodeport argocd-server-service -n argocd --tcp=port:80 --dry-run=client -o yaml > argocd-server-service.yaml
```

## Criando um aplicativo
Um aplicativo pode ser criado no Argo CD a partir da interface do usuário, da CLI ou escrevendo um manifesto do Kubernetes que pode ser passado ao kubectl para criar recursos.

