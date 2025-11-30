# Devops And Workflow Management With Argo (LFS256)

1. Course Information
## Informações do curso
## Visão geral da Linux Foundation

2. Introduction to Argo
## O que é Argo?
Argo é um conjunto de ferramentas nativas do Kubernetes que aprimoram os recursos de gerenciamento de fluxo de trabalho do Kubernetes. Ele inclui Argo Continuous Delivery (CD), Argo Workflows para executar tarefas complexas, Argo Events para gerenciamento de dependências baseado em eventos e Argo Rollouts para entrega progressiva. Essas ferramentas são projetadas para ajudar você a automatizar e gerenciar tarefas em um ambiente Kubernetes, facilitando a implantação, atualização e gerenciamento de aplicativos.

## Argo Continuous Delivery (CD)
Argo CD é uma ferramenta declarativa de GitOps Continuous Delivery para Kubernetes. Ela ajuda você a aplicar manifesto do repositório ao cluster e monitora continuamente o repositório (GitOps). Normalmente usada para implantação de infraestrutura e aplicativo. Ela fornece estratégias de atualização azul-verde e canário, integra-se com malhas de serviço e controladores de entrada para moldar o tráfego e automatiza a promoção e a reversão com base na análise. Ela é usada para implantar artefatos com segurança na Produção.

## Argo Workflows
O Argo Workflows, como uma extensão da API do Kubernetes, introduz um novo Workflow CRD, fornecendo às empresas um recurso de lote altamente adaptável semelhante a um Kubernetes Job. Essa extensibilidade torna o Workflows versátil e aplicável em vários domínios, com destaque especial para sua eficácia em Machine Learning (ML) e pipelines de dados. Aproveitar o Argo Workflows nesses contextos se tornou um movimento estratégico para inúmeras empresas, revelando seu potencial em orquestrar processos complexos perfeitamente.
Em sua essência, os Argo Workflows operam em um conjunto exclusivo de características e casos de uso. Cada etapa dentro de um fluxo de trabalho se manifesta como um pod, contribuindo para a modularidade e escalabilidade do processo geral. Este design permite paralelismo simplificado e utilização eficiente de recursos. Predominantemente, os Argo Workflows encontram seu ponto ideal em cenários de processamento e automação de dados, exemplificados pelo padrão fan-out fan-in. Este padrão permite que o fluxo de trabalho distribua tarefas amplamente, execute-as simultaneamente e consolide os resultados, tornando os Argo Workflows uma escolha robusta para cenários que exigem manipulação de dados intrincada e processos automatizados.

## Argo Rollouts
Argo Rollouts é um controlador de entrega progressiva para Kubernetes. Ele nasceu da necessidade devido à falta de estratégias de implantação mais sofisticadas do Kubernetes. Ele ajuda você a aplicar manifesto do repositório para o cluster e monitora continuamente o repositório (GitOps). Normalmente usado para implantação de infraestrutura e aplicativo. Ele fornece estratégias de atualização azul-verde e canário, integra-se com malhas de serviço e controladores de entrada para moldar o tráfego e automatiza a promoção e a reversão com base na análise. Ele é usado para implantar artefatos com segurança na Produção.

## Argo Events
Argo Events é uma estrutura de automação de fluxo de trabalho orientada a eventos para Kubernetes que ajuda você a acionar objetos do Kubernetes, Argo Workflows, cargas de trabalho sem servidor e outros processos em resposta a eventos de várias fontes, como webhooks, S3, programações, filas de mensagens, GCP PubSub e muito mais. Ele oferece suporte a eventos de mais de 20 fontes de eventos e permite que você personalize a lógica de restrição de nível empresarial para automação de fluxo de trabalho.
O Argo Events é composto por dois componentes principais: Triggers e Event Sources. Triggers são responsáveis ​​por executar ações quando um evento ocorre, enquanto Event Sources são responsáveis ​​por gerar eventos.
Alguns dos casos de uso do Argo Events incluem automatizar fluxos de trabalho de pesquisa, projetar um pipeline de CI/CD completo e automatizar tudo combinando Argo Events, Workflows & Pipelines, CD e Rollouts.

## Benefícios
- Aumenta a robustez, a segurança e a confiabilidade;
- Melhora o tracking das alterações e o processo de disaster recovery do ambiente
- Estratégias de deploys como Canary e Blue/Green
- Integrações com projetos da CNCF, como por exemplo: Helm, Prometheus, gRPC e NATS.

3. Argo CD

## Arquivo de configuração do kind para a criação do cluster

```/tmp/kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
- role: worker
- role: worker
- role: worker
```

## Comando para a criação do cluster utilizando o arquivo de configuração
```
kind create cluster --config /tmp/kind-config.yaml --name kumabes
```

## Principais Vantagens
- GitOps
- Continuous Delivery
- Rollback
- Multi-environment management
- UI and API

## Vocabulário
- Configuration
    - Application: uma coleção de manifestos k8s.
    - Application source type: helm ou kustomize
- States
    - Target state: Estado desejado, o que esta no git.
    - Live state: O estado atual no cluster k8s.
- Statuses
    - Sync status: O status que indica se o estado ativo se alinha com o estado de destino. Essencialmente, ele confirma se o aplicativo implantado no Kubernetes corresponde aos estados desejados descritos no repositório Git.
    - Sync operation status:  O status durante a fase de sincronização, especificando se ela falhou ou foi bem-sucedida.
    - Health status: o bem-estar do aplicativo, avaliando sua condição de execução e capacidade de lidar com solicitações.
- Actions
    - Refresh: ato de comparar o estado no git com o estado atual do cluster.
    - Sync: O processo transacional de um app para o estado de destino.

## Controllers
O Argo CD emprega controladores Kubernetes para suas funções principais. 

## API Server
- RBAC
- SSO
- Web UI
- CLI
- Argo Events
- CI/CD systems
- Manipula repositórios Git para controle de versão

## Repository Server
Conectado ao API Server está o Argo CD Repository Server , que é responsável por recuperar o estado desejado dos aplicativos dos repositórios Git e empacotá-lo em um formato que pode ser compreendido pelo Kubernetes.

## Application Controller
Controlador de aplicação
O Argo CD Application Controller é outro componente crucial. Ele compara continuamente o estado desejado do aplicativo (conforme definido em seus repositórios Git) com o estado ativo em seu cluster Kubernetes. Se detectar alguma discrepância, ele tomará medidas corretivas para garantir que o estado ativo corresponda ao estado desejado.

## How Does the Argo CD Reconciliation Loop Work?
O processo de reconciliação do Argo CD envolve o alinhamento da configuração pretendida especificada em um repositório Git com o estado atual no cluster Kubernetes. Esse loop contínuo, conhecido como reconciliing loop.

## Loop de reconciliação de CD do Argo
Ao utilizar o Helm, o Argo CD monitora o repositório Git, emprega o Helm para gerar o manifesto YAML do Kubernetes por meio da execução do modelo e o compara com o estado desejado do cluster, conhecido como status de sincronização. Se forem identificadas disparidades, o Argo CD utiliza o kubectl apply para implementar as alterações e atualizar o estado desejado do Kubernetes. Vale ressaltar que o Argo CD, nesse processo, opta pelo kubectl apply em vez do helm install para oferecer suporte a várias ferramentas de modelagem, mantendo sua função como uma ferramenta declarativa do GitOps sem estar vinculado a uma ferramenta de modelagem específica.

## Synchronization Principles
A fase de sincronização é uma operação muito importante e seu comportamento pode ser personalizado usando resource hooks e sync waves. Nesta seção, exploramos ambas as formas de personalização e aprendemos como usá-las.

### resource hooks
Uma sincronização, conforme descrito na seção "Vocabulário", é a transição de um aplicativo para o estado de destino. Há cinco definições possíveis de quando um gancho de recurso pode ser executado:

1. PreSync , execute antes da fase de sincronização (por exemplo, crie um backup antes da sincronização)
2. Sync , executar após todos os ganchos PreSync serem concluídos com sucesso e executar ações durante a aplicação dos manifestos (por exemplo, para estratégias de implementação mais complexas como azul-verde ou canário em vez de atualização contínua do Kubernetes)
3. PostSync , execute após todos os ganchos de sincronização e aplicativos bem-sucedidos e todos os recursos estiverem em estado saudável (por exemplo, execute verificações de integridade adicionais após a implantação ou execute verificações de integração)
4. Skip , indica que o Argo CD deve pular a aplicação do manifesto
5. SyncFail , executa quando a sincronização falha (por exemplo, operações de limpeza)

#### A seguir está um exemplo de um gancho de recurso de migração de esquema de banco de dados:
```
apiVersion: batch/v1
kind: Job
metadata:
  generateName: schema-migrate-
  annotations:
    argocd.argoproj.io/hook: PreSync
```

### sync waves
Essencialmente, as ondas de sincronização são uma maneira conveniente de dividir e ordenar manifestos a serem sincronizados. As ondas podem variar de valores negativos a positivos. Se não forem definidas, o valor padrão é onda zero. O uso de ondas de sincronização é obtido da mesma forma que os ganchos de recursos; usando anotações.

```
metadados:
  anotações:
    argocd.argoproj.io/sync-wave: "5"
```

Ambas as abordagens podem ser utilizadas simultaneamente. A operação de sincronização no Argo CD inicia com a ordenação de recursos com base nos seguintes critérios:
1. Resource hook phase annotation
2. Sync wave annotation
3. Kubernetes kind (for example, namespaces are prioritized, followed by other Kubernetes resources and then custom resources)
4. Name

Por razões de segurança, o Argo CD adiciona um atraso de 2 segundos entre cada onda de sincronização. Isso pode ser personalizado usando a variável de ambiente ARGOCD_SYNC_WAVE_DELAY .

## Simplifying Application Management
### Application
O Argo CD simplifica o gerenciamento de seus aplicativos em ambientes Kubernetes utilizando Definições de Recursos Personalizadas (CRDs).

```
apiVersion: argoproj.io/v1alpha1
kind: Application
metadata:
  name: guestbook
  namespace: argocd
spec:
  project: default
  source:
    repoURL: https://github.com/argoproj/argocd-example-apps.git
    targetRevision: HEAD
    path: guestbook
  destination:
    server: https://kubernetes.default.svc
    namespace: guestbook
```

### AppProject
Para uma organização eficiente, o Argo CD fornece o AppProject CRD . Isso permite que você agrupe aplicativos relacionados. Um exemplo de caso de uso envolve segregar aplicativos de serviços de utilidade, aumentando a clareza da estrutura do seu projeto. Exemplo:
```
apiVersion: argoproj.io/v1alpha1
kind: AppProject
metadata:
  name: my-project
  namespace: argocd
  # Finalizer that ensures that project is not deleted until it is not referenced by any application
  finalizers:
    - resources-finalizer.argocd.argoproj.io
spec:
  description: Example Project
  # Allow manifests to deploy from any Git repos
  sourceRepos:
  - '*'
  # Only permit applications to deploy to the guestbook namespace in the same cluster
  destinations:
  - namespace: guestbook
    server: https://kubernetes.default.svc
  # Deny all cluster-scoped resources from being created, except for Namespace
  clusterResourceWhitelist:
  - group: ''
    kind: Namespace
  # Allow all namespaced-scoped resources to be created, except for ResourceQuota, LimitRange, NetworkPolicy
  namespaceResourceBlacklist:
  - group: ''
    kind: ResourceQuota
  - group: ''
    kind: LimitRange
  - group: ''
    kind: NetworkPolicy
  # Deny all namespaced-scoped resources from being created, except for Deployment and StatefulSet
  namespaceResourceWhitelist:
  - group: 'apps'
    kind: Deployment
  - group: 'apps'
    kind: StatefulSet
  roles:
  # A role which provides read-only access to all applications in the project
  - name: read-only
    description: Read-only privileges to my-project
    policies:
    - p, proj:my-project:read-only, applications, get, my-project/*, allow
    groups:
    - my-oidc-group
  # A role which provides sync privileges to only the guestbook-dev application, e.g. to provide
  # sync privileges to a CI system
  - name: ci-role
    description: Sync privileges for guestbook-dev
    policies:
    - p, proj:my-project:ci-role, applications, sync, my-project/guestbook-dev, allow
    # NOTE: JWT tokens can only be generated by the API server and the token is not persisted
    # anywhere by Argo CD. It can be prematurely revoked by removing the entry from this list.
    jwtTokens:
    - iat: 1535390316
```

### Repository credentials
Em cenários do mundo real, acessar repositórios privados é comum. O Argo CD facilita isso usando Kubernetes Secrets e ConfigMaps. Para conceder acesso ao Argo CD, crie os recursos Kubernetes Secret necessários com um rótulo específico: argocd.argoproj.io/secret-type: repository . Exemplo:

```
apiVersion: v1
kind: Secret
metadata:
  name: private-repo-creds
  namespace: argocd
  labels:
    argocd.argoproj.io/secret-type: repository
stringData:
  url: 'htt‌ps://github.com/private/repo.git'
  username: <username>
  password: <password>
```

### Cluster credentials
Em casos em que o Argo CD gerencia vários clusters do Kubernetes, pode ser necessário acesso adicional. Para esse propósito, o Argo CD utiliza um tipo Secret distinto com o rótulo: argocd.argoproj.io/secret-type: cluster . Isso garante acesso seguro a clusters externos não incluídos inicialmente nos ambientes gerenciados do Argo CD. Exemplo:

```
apiVersion: v1
kind: Secret
metadata:
  name: external-cluster-creds
  labels:
    argocd.argoproj.io/secret-type: cluster
type: Opaque
stringData:
  name: external-cluster
  server: 'ht‌tps://external-cluster-api.com'
  config: |
    {
      "bearerToken": "<token>",
      "tlsClientConfig": {
         "insecure": false,
         "caData": "<certificate encoded in base64>"
      }
    }
```

## Plugins

A força do Argo CD está na sua extensibilidade por meio de plugins, permitindo que os usuários adaptem a ferramenta às suas necessidades específicas. Nesta seção, exploraremos o conceito de plugins do Argo CD, entenderemos como configurá-los usando ConfigMaps e testemunharemos o plugin Notifications em ação. Além disso, destacaremos alguns outros plugins notáveis ​​para mostrar a versatilidade das extensões do Argo CD.

## Understanding Plugins in Argo CD

Os plugins do Argo CD estendem as funcionalidades principais do sistema, oferecendo recursos adicionais além dos recursos padrão. Vamos nos concentrar nos plugins de Notificações, que desempenham um papel crucial em manter os usuários informados sobre eventos de implantação.

## Configuring Plugins with ConfigMaps
ConfigMaps no Kubernetes fornecem uma maneira de gerenciar dados de configuração e, no contexto do Argo CD, são empregados para configurar plugins. Vamos explorar a configuração do plugin Notifications usando um ConfigMap:

```
apiVersion: v1
kind: ConfigMap
metadata:
  name: argocd-notifications-cm
data:
  context: |
    region: east
    environmentName: staging

  template.a-slack-template-with-context: |
    message: "Something happened in {{ .context.environmentName }} in the {{ .context.region }} data center!"
```
Neste exemplo:

- A seção de contexto fornece informações contextuais, como o nome da região e do ambiente.
- A seção template.a-slack-template-with-context define um template de notificação do Slack usando o Go templating. Ele faz referência a valores da seção context para personalizar a mensagem.
- Este ConfigMap permite que os usuários ajustem dinamicamente o conteúdo da notificação com base em informações contextuais, proporcionando flexibilidade na resposta a diferentes cenários de implantação.


## How Plugins Work in Argo CD
Os plugins no Argo CD seguem um ciclo de vida específico, incluindo as fases de registro, inicialização e execução. Durante a inicialização, o Argo CD descobre e carrega os plugins disponíveis, inicializando-os para uso durante todo o ciclo de vida do aplicativo. Eventos críticos, como sincronização ou implantação do aplicativo, acionam os plugins associados.

## Plugins in Action: Notifications and Beyond
Vamos aplicar praticamente nosso conhecimento considerando um cenário em que uma implantação falha no ambiente de preparação na região leste. O plugin Notifications , configurado com o modelo fornecido, dispara uma notificação no Slack ou e-mail, como: "Algo aconteceu na preparação no data center leste!". Essa notificação imediata capacita os usuários a identificar e resolver rapidamente os problemas de implantação.
Além do plugin Notifications, o Argo CD suporta vários outros plugins que atendem a diversas necessidades. Alguns exemplos notáveis ​​incluem:
- Plug-in Image Updater : automatiza o processo de atualização de imagens de contêiner em manifestos do Kubernetes, garantindo que os aplicativos estejam sempre usando as versões mais recentes.
- ArgoCD Autopilot : simplifica os fluxos de trabalho do GitOps automatizando o gerenciamento de versões do Helm, facilitando a manutenção e a implantação de aplicativos.
- ArgoCD Interlace : aprimora a interface do usuário do Argo CD com recursos adicionais, fornecendo uma interface interativa e dinâmica para gerenciar aplicativos e implantações.

## Securing Argo CD

### Usar RBAC
- Por quê: Usar o RBAC é uma das práticas recomendadas mais importantes para proteger o Argo CD, pois é vital gerenciar as permissões do usuário de forma eficaz, garantindo que apenas pessoal autorizado tenha acesso a recursos específicos. Essa abordagem minimiza o risco de alterações ou acesso não autorizado, o que é crucial em um ambiente de implantação contínua.
- Como: Para implementar o RBAC no Argo CD, defina funções com permissões específicas no ConfigMap argocd-rbac-cm, alinhando com as responsabilidades do usuário. Atribua essas funções a usuários ou grupos por meio de RoleBindings ou ClusterRoleBindings para níveis de acesso apropriados. Garanta o acesso mínimo necessário por função, aderindo ao princípio do menor privilégio. Audite regularmente as configurações do RBAC para refletir as necessidades atuais e as políticas de segurança, ajustando funções e permissões conforme necessário. Utilize as funções predefinidas do Argo CD para padrões de acesso comuns, personalizando conforme necessário. Teste as configurações para garantir a aplicação e a segurança adequadas.

### Gerencie segredos com segurança

- Por quê: O gerenciamento de segredos é essencial para proteger informações confidenciais, como chaves de API, senhas e certificados. O gerenciamento eficaz de segredos previne acesso não autorizado e possíveis violações de segurança. No contexto do Kubernetes e do Argo CD, isso envolve lidar com segredos de forma que eles não sejam expostos ou registrados.
- Como: Use o gerenciamento de segredos nativos do Kubernetes para armazenar e manipular dados confidenciais. Garanta que os segredos sejam criptografados em repouso e em trânsito. Para maior segurança, considere implementar camadas adicionais de segurança, como usar variáveis ​​de ambiente, recursos de criptografia nativos do Kubernetes ou integrar com outras soluções de gerenciamento de segredos que se encaixem no ecossistema do Kubernetes.

### Atualizar regularmente o CD Argo

- Por quê: Manter o Argo CD atualizado é crucial para a segurança. As atualizações geralmente incluem patches para vulnerabilidades, melhorias na funcionalidade e recursos de segurança aprimorados. Manter-se atualizado ajuda a proteger contra ameaças emergentes e a aproveitar os últimos aprimoramentos de segurança.
- Como: Estabeleça uma rotina para verificar e aplicar atualizações ao Argo CD. Isso pode ser feito por meio de verificações de atualização automatizadas ou monitoramento manual de lançamentos do Argo CD. Use estratégias de implantação padrão do Kubernetes para aplicar atualizações com o mínimo de interrupção. Garanta que o processo de atualização inclua testes em um ambiente de preparação antes de implantar na produção para evitar problemas inesperados.

Para obter informações detalhadas adicionais sobre as práticas de segurança do Argo CD, especialmente tópicos como Single Sign-On (SSO), registro de auditoria e políticas de rede, consulte a documentação de segurança do Argo CD .

## Enhancing Deployment Efficiency with Helm and Kustomize
Fazendo a transição de implantações padrão, o Helm aprimora o ArgoCD com gerenciamento de modelos e pacotes, simplificando implantações em todos os ambientes. O Kustomize adiciona camadas de personalização a implantações sem alterar manifestos base, simplificando ajustes específicos do ambiente. Essas ferramentas facilitam implantações escaláveis ​​e com redução de erros no ArgoCD.
Para mais informações, visite os guias do ArgoCD sobre Helm e Kustomize .

## Instalando o CRD do ArgoCD
```
kubectl create namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
```

## Instalando a CLI do ArgoCD
```
wget -O argocd https://github.com/argoproj/argo-cd/releases/download/v2.14.4/argocd-linux-amd64
chmod +x argocd
sudo mv argocd /usr/local/bin/argocd
argocd version
```

## Obtendo a senha inicial do ArgoCD
```
kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d;echo
```

## Fazendo port-forward para acessar o Argo Web UI
```
kubectl -n argocd port-forward svc/argocd-server 8443:443
```

## Fazendo login no ArgoCD via CLI
```
argocd login localhost:8443 --insecure
argocd -h
argocd proj list
```

## Exemplo de RBAC
```argocd-cm.yaml
apiVersion: v1
data:
  accounts.rkumabe: apiKey, login
kind: ConfigMap
metadata:
  annotations:
    kubectl.kubernetes.io/last-applied-configuration: |
      {"apiVersion":"v1","kind":"ConfigMap","metadata":{"annotations":{},"labels":{"app.kubernetes.io/name":"argocd-cm","app.kubernetes.io/part-of":"argocd"},"name":"argocd-cm","namespace":"argocd"}}
  creationTimestamp: "2025-03-08T18:17:25Z"
  labels:
    app.kubernetes.io/name: argocd-cm
    app.kubernetes.io/part-of: argocd
  name: argocd-cm
  namespace: argocd
  resourceVersion: "17805"
  uid: e7ef1eb9-d13d-41e0-9bec-a9c05be44fc9
```

## Then set the password with this command:
```
argocd account update-password --account rkumabe --new-password Developer123
``` 

## Define the RBAC rules
``` 
kubectl edit cm argocd-rbac-cm -n argocd
``` 

```argocd-rbac-cm.yaml
.
.
.
data:
  policy.default: role:readonly
  policy.csv: |
    p, role:rkumabe, applications, sync, */*, allow
    g, rkumabe, role:rkumabe
``` 

4. Argo Workflows

## Introduction
Argo Workflows, uma extensão do Argo, uma ferramenta popular do GitOps projetada para entrega contínua declarativa de aplicativos Kubernetes. 
- Defina e explique a estrutura de um fluxo de trabalho do Argo.
- Reconhecer elementos-chave, como metadata, spec, entrypoint e templates.
- Entenda a função dos templates nos workflows.
- Identifique e explique os principais componentes dos Workflows do Argo, incluindo o controlador de Workflows e a interface do usuário.
- Entenda como o Argo Workflows agenda e executa tarefas.
- Mergulhe nas responsabilidades do Controlador de Workflows.

## Argo Workflows Core Concepts

### Workflow
Um fluxo de trabalho é uma série de tarefas, processos ou etapas que são executadas em uma sequência específica para atingir uma meta ou resultado específico. Os fluxos de trabalho são predominantes em vários domínios, incluindo negócios, desenvolvimento de software e gerenciamento de projetos. No contexto do Argo e de outras ferramentas DevOps, um fluxo de trabalho se refere especificamente a uma sequência de etapas automatizadas envolvidas na implantação, teste e promoção de aplicativos de software.
No Argo, o termo Workflow é um Kubernetes Custom Resource que representa uma sequência de tarefas ou etapas que são definidas e orquestradas para atingir um objetivo específico. É uma abstração de nível superior que permite aos usuários descrever processos, dependências e condições complexas de forma estruturada e declarativa. Um Workflow também mantém o estado de um fluxo de trabalho.
A seguir, daremos uma olhada nas especificações de um fluxo de trabalho simples.
A parte principal de uma especificação de fluxo de trabalho contém um ponto de entrada e uma lista de modelos, conforme mostrado no exemplo abaixo:

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: hello-world-
spec:
  entrypoint: whalesay
  templates:
- name: whalesay
  container:
    image: docker/whalesay
    command: [cowsay]
    args: ["hello world"]
```

Uma especificação de fluxo de trabalho tem duas partes principais:
- Entrypoint: Especifica o nome do template que serve como entrypoint para o workflow. Ele define o ponto inicial da execução do workflow.
- Templates: Um template representa uma etapa ou tarefa no fluxo de trabalho que deve ser executada. Existem seis tipos de templates que apresentaremos a seguir.


### Template Types
Um modelo pode ser contêineres, scripts, DAGs ou outros tipos, dependendo da estrutura do fluxo de trabalho, e é dividido em dois grupos: definições de modelo e invocadores de modelo.
1. Template Definitions
  - Container: Um Container é o tipo de template mais comum e representa uma etapa no fluxo de trabalho que executa um container. Ele é adequado para executar aplicativos ou scripts em container. Exemplo:
  ```
  - name: whalesay
    container:
      image: docker/whalesay
      command: [cowsay]
      args: ["hello world"]  
  ```
  - Resource: Um Resource representa um modelo para criar, modificar ou excluir recursos do Kubernetes. Ele é útil para executar operações em objetos do Kubernetes. Exemplo:
  ```
  - name: k8s-owner-reference
    resource:
      action: create
      manifest: |
        apiVersion: v1
        kind: ConfigMap
        metadata:
          generateName: owned-eg-
        data:
          some: value
  ```  
  - Script: Um Script é similar ao template de container, mas permite especificar o script inline sem referenciar uma imagem de container externa. Ele pode ser usado para scripts simples ou one-liners. Exemplo:
  ```
  - name: gen-random-int
    script:
      image: python:alpine3.6
      command: [python]
      source: |
        import random
        i = random.randint(1, 100)
        print(i)  
  ```    
  - Suspend: Um Suspend é um modelo que suspende a execução, seja por uma duração ou até que seja retomada manualmente. Ele pode ser retomado usando a CLI, o endpoint da API ou a UI. Exemplo:
  ```
  - name: delay
    suspend:
      duration: "20s"
  ```  

2. Template Invocators
  - DAG: Um DAG permite definir nossas tarefas como um gráfico de dependências. É benéfico para fluxos de trabalho com dependências complexas e execução condicional. Exemplo:
  ```
  - name: diamond
    dag:
      tasks:
      - name: A
        template: echo
      - name: B
        dependencies: [A]
        template: echo
      - name: C
        dependencies: [A]
        template: echo
      - name: D
        dependencies: [B, C]
        template: echo
  ```
  - Steps: Etapas definem várias etapas dentro de um modelo, pois várias etapas precisam ser executadas sequencialmente ou em paralelo.
  ```
  - name: hello-hello-hello
    steps:
    - - name: step1
        template: prepare-data
    - - name: step2a
        template: run-data-first-half
      - name: step2b
        template: run-data-second-half
  ```
### Outputs
No Argo Workflows, a seção outputs dentro de um modelo de etapa permite que você defina e capture outputs que podem ser acessados ​​por etapas subsequentes ou referenciados na definição do fluxo de trabalho. 
O Output compreende dois conceitos-chave:
- Defining Outputs: Você define saídas dentro de um modelo de etapa usando a seção outputs. Cada saída tem um nome e um caminho dentro do contêiner onde os dados ou artefato são produzidos.
- Accessing Outputs: você pode referenciar as saídas de uma etapa usando expressões de modelo em etapas subsequentes ou na definição do fluxo de trabalho.

Vamos considerar um exemplo simples em que uma etapa gera um parâmetro de saída e um artefato de saída, e outra etapa os consome:

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: artifact-passing-
spec:
  entrypoint: artifact-example
  templates:
  - name: artifact-example
    steps:
    - - name: generate-artifact
        template: whalesay
    - - name: consume-artifact
        template: print-message
        arguments:
          artifacts:
          - name: message
            from: "{{steps.generate-artifact.outputs.artifacts.hello-art}}"

  - name: whalesay
    container:
      image: docker/whalesay:latest
      command: [sh, -c]
      args: ["cowsay hello world | tee /tmp/hello_world.txt"]
    outputs:
      artifacts:
    - name: hello-art
      path: /tmp/hello_world.txt

  - name: print-message
    inputs:
      artifacts:
      - name: message
        path: /tmp/message
    container:
      image: alpine:latest
      command: [sh, -c]
      args: ["cat /tmp/message"]
```

Primeiro, o template whalesay cria um arquivo chamado /tmp/hello-world.txt usando o comando cowsay . Em seguida, ele gera esse arquivo como um artefato chamado hello-art . O template artifact-example fornece o artefato hello-art gerado como uma saída da etapa generate-artifact . Finalmente, o template pint-message pega um artefato de entrada chamado message e o consome descompactando-o no caminho /tmp/message e usando o comando cat para imprimi-lo na saída padrão.

### Workflow Template
um WorkflowTemplate é um recurso que define um modelo de fluxo de trabalho reutilizável e compartilhável, permitindo que os usuários encapsulem lógica de fluxo de trabalho, parâmetros e metadados. 
Aqui está um exemplo de uma definição simples de WorkflowTemplate no Argo Workflows:

```
apiVersion: argoproj.io/v1alpha1
kind: WorkflowTemplate
metadata:
  name: sample-template
spec:
  templates:
   - name: hello-world
     inputs:
       parameters:
         - name: msg
           value: "Hello World!"
     container:
       image: docker/whalesay
       command: [cowsay]
       args: ["{{inputs.parameters.msg}}"]
```

Neste exemplo:

O WorkflowTemplate é denominado sample-template
Ele contém um modelo: hello-world
O modelo hello-world recebe um parâmetro message (com um valor padrão de "Hello, World!") e gera um arquivo com a mensagem especificada.
Uma vez definido, este WorkflowTemplate pode ser referenciado e instanciado dentro de múltiplos fluxos de trabalho. Por exemplo:

```
apiVersion: argoproj.io/v1alpha1
kind: Workflow
metadata:
  generateName: hello-world-
spec:
entrypoint: whalesay
templates:
  - name: whalesay
    steps:
      - - name: hello-world
          templateRef:
            name: sample-template
            template: hello-world
```
Este fluxo de trabalho faz referência ao WorkflowTemplate chamado sample-template, herdando efetivamente a estrutura e a lógica definidas no modelo.
Usar WorkflowTemplates é benéfico quando você quer padronizar e reutilizar padrões de fluxo de trabalho específicos, facilitando o gerenciamento, a manutenção e o compartilhamento de definições de fluxo de trabalho dentro da sua organização. Eles também ajudam a reforçar a consistência e reduzir a redundância em vários fluxos de trabalho.

## Argo Workflows Architecture
Argo Workflows é uma plataforma de orquestração de fluxo de trabalho de código aberto projetada para Kubernetes. Ela permite que os usuários definam, executem e gerenciem fluxos de trabalho complexos usando o Kubernetes como o ambiente de execução subjacente.

### Building Blocks
- Argo Server: é um componente central que gerencia os recursos gerais do fluxo de trabalho, estado e interações. Ele expõe uma API REST para envio, monitoramento e gerenciamento do fluxo de trabalho. O servidor mantém o estado dos fluxos de trabalho e sua execução e interage com o servidor da API do Kubernetes para criar e gerenciar recursos.
- Workflow Controller: é um componente crítico dentro do sistema Argo Workflows. Ele é responsável por gerenciar o ciclo de vida dos fluxos de trabalho, interagir com o servidor da API do Kubernetes e garantir a execução dos fluxos de trabalho de acordo com suas especificações. O Argo Workflows Controller monitora continuamente o servidor da API do Kubernetes para alterações relacionadas aos Recursos Personalizados (CRs) do Argo Workflows. O CR primário envolvido é o Workflow, que define a estrutura e as etapas do fluxo de trabalho. Ao detectar a criação ou modificação de um CR do Workflow, o controlador inicia a execução do fluxo de trabalho correspondente. O controlador é responsável por gerenciar o ciclo de vida completo de um fluxo de trabalho, incluindo sua criação, execução, monitoramento e conclusão. Ele também resolve dependências entre etapas dentro de um fluxo de trabalho. Ele garante que as etapas sejam executadas na ordem correta, com base nas dependências especificadas na definição do fluxo de trabalho.
- Argo UI: é uma interface de usuário baseada na web para monitorar e gerenciar fluxos de trabalho visualmente. Ela permite que os usuários visualizem o status do fluxo de trabalho, logs e artefatos, bem como enviem novos fluxos de trabalho.

Tanto o Workflow Controller quanto o Argo Server são executados no namespace argocd. Podemos optar por uma das instalações cluster ou namespaced, no entanto, os Workflows gerados e os Pods serão executados no respectivo namespace.

### Argo Workflow building blocks
Um usuário define um fluxo de trabalho usando arquivos YAML ou JSON, especificando a sequência de etapas, dependências, entradas, saídas, parâmetros e quaisquer outras configurações relevantes. Em seguida, o arquivo de definição de fluxo de trabalho é enviado ao cluster do Kubernetes onde o Argo Workflows é implantado. Esse envio pode ser feito por meio do Argo CLI, Argo UI ou programaticamente por meio de clientes da API do Kubernetes.
O componente Workflow Controller do Argo Workflows monitora continuamente o cluster do Kubernetes para novos envios de fluxo de trabalho ou atualizações para fluxos de trabalho existentes. Quando um novo fluxo de trabalho é enviado, o Workflow Controller analisa a definição do fluxo de trabalho para validar sua sintaxe e semântica. Se houver erros ou inconsistências, o Workflow Controller os relata ao usuário para correção.
Depois que a definição do fluxo de trabalho é validada, o Workflow Controller cria os recursos do Kubernetes necessários para representar o fluxo de trabalho, como CRDs (Custom Resource Definitions) do fluxo de trabalho e Pods, Serviços, ConfigMaps e Segredos associados.
Por fim, o Workflow Controller começa a executar as etapas definidas no fluxo de trabalho. Cada etapa pode envolver a execução de contêineres, a execução de scripts ou a realização de outras ações especificadas pelo usuário. O Argo Workflows garante que as etapas sejam executadas na ordem correta com base nas dependências definidas no fluxo de trabalho.

### Argo Workflow Overview
Cada etapa e DAG causa a geração de um Pod que compreende três contêineres:
- init: um template que contém um contêiner init que executa tarefas de inicialização. Neste caso, ele ecoa uma mensagem e dorme por 30 segundos, mas você pode substituir esses comandos por suas etapas de inicialização reais.
- main: um modelo contém o contêiner principal que executa o processo primário assim que a inicialização é concluída.
- wait: um contêiner que executa tarefas como limpeza, salvamento de parâmetros e artefatos.

## Use Cases for Argo Workflows
Argo Workflows é uma ferramenta versátil com uma ampla gama de casos de uso no contexto do Kubernetes e ambientes conteinerizados. Aqui estão alguns casos de uso comuns onde o Argo Workflows pode ser benéfico:
- Para orquestrar pipelines de processamento de dados de ponta a ponta , incluindo tarefas de extração, transformação e carregamento de dados (ETL).
- Em projetos de aprendizado de máquina , os fluxos de trabalho do Argo podem orquestrar tarefas como pré-processamento de dados, treinamento de modelos, avaliação e implantação.
- O Argo Workflows pode servir como base para pipelines de integração contínua e implantação contínua (CI/CD). Ele permite a automação de construção, teste e implantação de aplicativos em um ambiente Kubernetes.
- Para processamento em lote e tarefas periódicas, o Argo Workflows pode ser configurado para ser executado em intervalos especificados ou com base em agendamentos cron. Isso é útil para automatizar tarefas de rotina, geração de relatórios e outros trabalhos agendados.

## Lab Exercises
1.
2.
3.

## Knowledge Check


5. Argo Rollouts
```

```

6. Argo Events
```

```

7. Course Completion
```

```
