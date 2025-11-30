# CNPA

Para obter a certificação Certified Cloud Native Platform Engineering Associate (CNPA), é fundamental dominar os conceitos e práticas que formam a base da engenharia de plataformas nativas da nuvem. A seguir, apresento um guia de estudos estruturado com base nos domínios e competências da certificação, incluindo referências para aprofundamento.

### Estratégia de Estudos

1.  **Fundamentos Primeiro:** Comece pelos domínios com maior peso na prova, como "Platform Engineering Core Fundamentals". Garanta que você tenha uma base sólida antes de avançar.
2.  **Aprendizado Prático:** A engenharia de plataformas é uma disciplina prática. Não se limite à teoria; crie um ambiente de laboratório (Minikube, Kind ou uma conta em um provedor de nuvem) para experimentar as ferramentas e conceitos.
3.  **Combine Recursos:** Alterne entre diferentes tipos de materiais de estudo — artigos, vídeos e documentação oficial — para obter diferentes perspectivas sobre os mesmos tópicos.
4.  **Simulados e Revisão:** Antes da prova, revise todos os tópicos e, se possível, faça simulados para testar seu conhecimento e familiarizar-se com o formato das questões.

-----

## Guia de Estudos por Domínio

### 1\. Platform Engineering Core Fundamentals (36%)

Este é o domínio mais importante da prova, cobrindo os conceitos essenciais da engenharia de plataformas.

  * **Tópicos Principais:**

      * **Gerenciamento Declarativo de Recursos:** Entenda a diferença entre abordagens imperativas e declarativas, com foco em como o Kubernetes utiliza manifestos YAML para definir o estado desejado dos recursos.
      * **Práticas de DevOps:** Compreenda como a engenharia de plataformas habilita e melhora as práticas de DevOps, focando em automação, colaboração e feedback.
      * **Conceitos de Infraestrutura:** Tenha clareza sobre conceitos como contêineres, orquestração (Kubernetes), redes e armazenamento em um contexto nativo da nuvem.
      * **Arquitetura e Objetivos da Plataforma:** Saiba o que é uma plataforma de engenharia, seus objetivos (reduzir a carga cognitiva, acelerar a entrega), seus componentes e como ela serve aos times de desenvolvimento.
      * **Fundamentos de CI/CD:** Entenda o que é Integração Contínua e Entrega Contínua e como esses processos são a espinha dorsal da automação na plataforma.

  * **Recurso de Estudo:**

      * **Artigo/Curso:** [What is Platform Engineering?](https://platformengineering.org/blog/what-is-platform-engineering) - Um excelente ponto de partida do community hub de Platform Engineering.
      * **Vídeo (YouTube):** [What is Platform Engineering? A Best Practices Guide](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3Dr_24i4So_Jk) - Um vídeo do canal da "The Linux Foundation" que oferece uma ótima visão geral.

-----

### 2\. Platform Observability, Security, and Conformance (20%)

Este domínio foca em garantir que a plataforma seja observável, segura e em conformidade com as políticas da organização.

  * **Tópicos Principais:**

      * **Fundamentos de Observabilidade:** Conheça os três pilares da observabilidade: **logs** (registros de eventos), **métricas** (dados numéricos ao longo do tempo) e **traces** (rastreamento de requisições através de múltiplos serviços). Ferramentas como Prometheus, Grafana, Jaeger e o padrão OpenTelemetry são essenciais.
      * **Comunicação Segura de Serviços:** Entenda conceitos como mTLS (mutual TLS) para garantir que a comunicação entre microsserviços seja autenticada e criptografada, geralmente implementado com um *service mesh* como Istio ou Linkerd.
      * **Mecanismos de Política:** Estude como motores de política, como o Open Policy Agent (OPA), são usados para aplicar regras de governança e segurança na plataforma (ex: restringir a criação de serviços públicos).
      * **Segurança no Kubernetes e CI/CD:** Aprenda sobre os fundamentos de segurança do Kubernetes (RBAC, Pod Security Standards, Network Policies) e como integrar ferramentas de verificação de segurança (SAST, DAST, verificação de vulnerabilidades) nos pipelines de CI/CD.

  * **Recurso de Estudo:**

      * **Artigo/Curso:** [The 3 Pillars of Observability: Logs, Metrics, and Traces](https://www.google.com/search?q=https://www.cncf.io/blog/2021/08/11/the-3-pillars-of-observability-logs-metrics-and-traces/) - Um artigo da CNCF que detalha os conceitos de observabilidade.
      * **Vídeo (YouTube):** [Kubernetes Security 101](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3Dr-z23d_G23A) - Um vídeo que cobre os principais aspectos de segurança no Kubernetes.

-----

### 3\. Continuous Delivery & Platform Engineering (16%)

Este domínio aprofunda a relação entre a entrega contínua e a engenharia de plataformas, com ênfase no GitOps.

  * **Tópicos Principais:**

      * **Pipelines de CI/CD:** Entenda a estrutura de um pipeline de CI, incluindo compilação, testes e empacotamento da aplicação em um contêiner.
      * **GitOps:** Compreenda o que é GitOps, seus princípios (declarativo, versionado no Git, automação) e como ele é usado para gerenciar tanto a infraestrutura quanto as aplicações. O Git se torna a única fonte da verdade.
      * **Ferramentas de GitOps:** Familiarize-se com ferramentas como Argo CD e FluxCD, que são as principais implementações de GitOps no ecossistema Kubernetes.
      * **Resposta a Incidentes:** Saiba como a plataforma pode auxiliar na resposta a incidentes, fornecendo ferramentas de observabilidade e automação para rollback.

  * **Recurso de Estudo:**

      * **Artigo/Curso:** [Guide To GitOps](https://www.google.com/search?q=https://www.weave.works/technologies/gitops/) - O guia original da Weaveworks, empresa que cunhou o termo GitOps.
      * **Vídeo (YouTube):** [Argo CD Tutorial for Beginners](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3D22_O2B-Hje8) - Um tutorial prático que demonstra os conceitos de GitOps usando Argo CD.

-----

### 4\. Platform APIs and Provisioning Infrastructure (12%)

Este domínio aborda como a plataforma expõe suas capacidades de forma programática e automatizada.

  * **Tópicos Principais:**

      * **Loop de Reconciliação do Kubernetes:** Entenda o conceito central do Kubernetes, onde os *controllers* trabalham continuamente para fazer com que o estado atual do cluster corresponda ao estado desejado definido nos manifestos.
      * **APIs de Self-Service (CRDs):** Aprenda como os Custom Resource Definitions (CRDs) são usados para estender a API do Kubernetes, permitindo que você crie suas próprias APIs de plataforma (ex: `apiVersion: platform.example.com/v1`, `kind: Database`).
      * **Provisionamento de Infraestrutura com Kubernetes:** Estude ferramentas como Crossplane, que utilizam o padrão de CRDs e *controllers* para provisionar e gerenciar infraestrutura externa (bancos de dados, buckets S3, etc.) diretamente pelo Kubernetes.
      * **Padrão Operator:** Entenda o que é um Operator, que combina um CRD com um *controller* para automatizar tarefas operacionais complexas de uma aplicação.

  * **Recurso de Estudo:**

      * **Documentação Oficial:** [Kubernetes Custom Resources](https://kubernetes.io/docs/concepts/extend-kubernetes/api-extension/custom-resources/)
      * **Vídeo (YouTube):** [What is Crossplane? Infrastructure as Code using CRDs](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3Di_MCAG_3gXQ) - Um vídeo que explica como o Crossplane utiliza os conceitos de API do Kubernetes para provisionar infraestrutura.

-----

### 5\. IDPs and Developer Experience (8%)

Este domínio foca na interface da plataforma com seus usuários: os desenvolvedores.

  * **Tópicos Principais:**

      * **Internal Developer Platform (IDP):** Entenda o conceito de um IDP como a implementação concreta da engenharia de plataformas, fornecendo um caminho pavimentado (*golden path*) para os desenvolvedores.
      * **Catálogos de Serviço e Portais de Desenvolvedor:** Conheça ferramentas como o Backstage, que criam um portal centralizado onde os desenvolvedores podem descobrir e consumir as capacidades da plataforma (criar um novo serviço, provisionar um banco de dados, ver a documentação).
      * **Experiência do Desenvolvedor (DevEx):** Entenda como o objetivo de um IDP é melhorar a experiência do desenvolvedor, reduzindo a complexidade e permitindo que eles se concentrem na criação de valor.
      * **IA/ML na Automação:** Tenha uma noção de como a inteligência artificial pode ser usada para otimizar processos, como sugerir otimizações de recursos ou automatizar análises de logs.

  * **Recurso de Estudo:**

      * **Site Oficial:** [Backstage - An open platform for building developer portals](https://backstage.io/)
      * **Vídeo (YouTube):** [Backstage 101: How to get your own Developer Portal up and running](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3Dj5CUm3M627U) - Uma introdução prática ao Backstage.

-----

### 6\. Measuring your Platform (8%)

Este domínio trata de como medir o sucesso e a eficiência da sua iniciativa de plataforma.

  * **Tópicos Principais:**

      * **Métricas DORA:** Conheça as quatro métricas chave de performance de DevOps (DORA metrics): **Lead Time for Changes**, **Deployment Frequency**, **Mean Time to Recovery (MTTR)** e **Change Failure Rate**. Entenda como a plataforma ajuda a otimizar essas métricas.
      * **Eficiência da Plataforma e Produtividade do Time:** Saiba como medir a adoção da plataforma, a satisfação do desenvolvedor e a redução da carga cognitiva como indicadores de sucesso.

  * **Recurso de Estudo:**

      * **Artigo/Curso:** [DORA Metrics](https://www.google.com/search?q=https://dora.dev/devops-capabilities/operations/monitoring-and-observability/) - O site oficial do grupo DORA (DevOps Research and Assessment).
      * **Vídeo (YouTube):** [How to Measure and Improve Your DevOps Performance with DORA Metrics](https://www.google.com/search?q=https://www.youtube.com/watch%3Fv%3D5g0i_H4oP9k) - Um vídeo explicativo sobre as métricas DORA.

Boa sorte nos seus estudos e na sua certificação\! 🚀