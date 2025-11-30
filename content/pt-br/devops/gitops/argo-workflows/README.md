# Argo Workflows

## O que é o Argo Workflows?
Argo Workflows é um projeto de código aberto que permite o gerenciamento de pipeline de CI/CD. É um mecanismo de fluxo de trabalho que permite a orquestração de trabalhos paralelos no Kubernetes. 

O Argo Workflows é implementado como uma definição de recurso personalizada (CRD) do Kubernetes, que permite que você:
- Defina fluxos de trabalho do Kubernetes usando contêineres separados para cada etapa do fluxo de trabalho.
- Modele fluxos de trabalho com gráficos acíclicos direcionados (DAG) para capturar dependências entre várias etapas ou definir sequências de tarefas.
- Execute tarefas de processamento de dados com uso intensivo de computação ou de aprendizado de máquina de forma rápida e fácil. 
- Execute pipelines de CI/CD nativamente no Kubernetes sem configurar uma solução complexa de desenvolvimento de aplicativos.
Isto faz parte de uma extensa série de guias sobre o Kubernetes .

```
kubectl create ns argo
kubectl apply -n argo -f https://raw.githubusercontent.com/argoproj/argo-workflows/master/manifests/quick-start-postgres.yaml
```