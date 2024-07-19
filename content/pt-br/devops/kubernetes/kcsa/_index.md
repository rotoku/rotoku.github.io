---
title: "KCSA"
linkTitle: "KCSA"
date: 2024-02-14
weight: 5
---

---

---

---

# Kubernetes and Cloud Native Security Associate (KCSA)

## Why is compliance with supply chain security standards crucial in a Kubernetes environment?

- To ensure the security of third-party components and dependencies used in containerized applications
  > Compliance with supply chain security standards in a Kubernetes environment is crucial to ensure the security of third-party components and dependencies used in containerized applications. As Kubernetes environments often rely on external sources for container images, libraries, and other components, it's vital to ensure these elements are secure and free from vulnerabilities. Adhering to supply chain security standards helps in preventing the introduction of malicious code or vulnerabilities, thereby protecting the Kubernetes ecosystem from potential security breaches and attacks.

## Why is it important to secure the Kubernetes Scheduler in a multi-tenant environment?

- To prevent unauthorized or malicious scheduling that could impact cluster security
  > Securing the Kubernetes Scheduler in a multi-tenant environment is crucial to prevent unauthorized or malicious scheduling activities that could impact the overall security of the cluster. If the Scheduler is compromised, it could lead to the placement of pods in a manner that breaches isolation between tenants, potentially allowing malicious actors to access or disrupt other tenants' workloads. Ensuring the Scheduler's integrity and security helps maintain strict isolation and protects against such threats.

## For ensuring compliance with industry security standards in a Kubernetes environment, which of the following would be the most effective approach?

- Regularly performing security audits and compliance scans
  > Regularly performing security audits and compliance scans is the most effective approach for ensuring compliance with industry security standards in a Kubernetes environment. These audits and scans help in identifying non-compliance issues, vulnerabilities, and misconfigurations, and in ensuring that security practices align with the required standards.

## How does implementing a service mesh contribute to observability and monitoring in Kubernetes from a security perspective?

- By enabling detailed logging and tracing of service interactions for security analysis
  > Implementing a service mesh contributes to observability and monitoring in Kubernetes from a security perspective by enabling detailed logging and tracing of service interactions. This allows for comprehensive monitoring of how services communicate and interact with each other, including the detection of unusual or potentially malicious patterns. Such detailed observability is essential for security analysis, helping to identify and respond to security incidents more effectively within the Kubernetes environment.

## What is a key security practice for the Kubernetes Kubelet to protect against unauthorized node access?

- Enabling and configuring Kubelet client certificate rotation
  > Enabling and configuring Kubelet client certificate rotation is a key security practice for protecting against unauthorized node access. This ensures that the Kubelet's authentication credentials are regularly updated, reducing the risk of long-term credential compromise. Certificate rotation helps in maintaining a strong security posture by periodically changing the credentials used by the Kubelet to authenticate to the Kubernetes API server, thereby safeguarding against unauthorized access to the node.

## In a Kubernetes environment, what is a key security benefit of using dynamic provisioning for persistent volumes?

- To minimize the risk of misconfiguration and human error in volume creation
  > The key security benefit of using dynamic provisioning for persistent volumes in a Kubernetes environment is to minimize the risk of misconfiguration and human error in the creation of volumes. Dynamic provisioning automates the process of creating and managing storage resources, reducing the likelihood of manual errors or misconfigurations that could lead to security vulnerabilities, such as improper access controls or unencrypted sensitive data.

## In the context of Kubernetes platform security, how does a service mesh like Istio improve security?

- By enabling mutual TLS (mTLS) for secure service-to-service communication
  > A service mesh like Istio improves security in a Kubernetes environment by enabling mutual TLS (mTLS) for secure service-to-service communication. mTLS ensures that both the client and server in a communication verify each other's identities, enabling encrypted and authenticated communication between services. This is crucial for protecting sensitive data and communications from eavesdropping and man-in-the-middle attacks within the Kubernetes cluster

## Which of the following is an effective isolation technique for securing containerized applications by preventing container escape attacks?

- Utilizing Runtime Security Tools
  > Runtime Security Tools, such as Falco or Sysdig, are designed to monitor and protect containers at runtime. They can detect anomalous activities and potential threats, such as container escape attempts, providing an effective isolation technique to secure containerized applications against such attacks.

## What is an important security consideration when configuring the Kubernetes Scheduler to ensure the safe placement of pods in a multi-tenant environment?

- Configuring pod affinity and anti-affinity rules
  > In a multi-tenant environment, configuring pod affinity and anti-affinity rules in the Kubernetes Scheduler is important for security. These rules help in safely placing pods by ensuring that they are scheduled on appropriate nodes, potentially isolating workloads of different tenants for security reasons, and preventing conflicts or unauthorized access between them.

## In the context of the 4Cs of Cloud Native Security, which layer primarily focuses on the protection of sensitive data and compliance with regulatory frameworks?

- Cloud Infrastructure Security
  > Cloud Infrastructure Security is crucial for protecting sensitive data and ensuring compliance with various regulatory frameworks. This layer involves securing the underlying infrastructure on which applications and services are hosted, including networks, servers, and storage systems.

## In Kubernetes, what is a key security practice for pods to ensure that they only communicate with authorized services or components within the cluster?

- Applying Network Policies to pods
  > Applying Network Policies to pods in Kubernetes is a key security practice to control and restrict which network connections are allowed to and from the pods. This ensures that pods only communicate with authorized services or components, thereby preventing potential security breaches through unauthorized network access.

## What is the DREAD Threat Modeling approach?

- Microsoft developed the DREAD threat modeling approach to detect and prioritize threats so that serious threats can be mitigated first. It was first published in ‘Writing Secure Code’ 2nd edition by David LeBlanc and Michael Howard in 2002. Though Microsoft stopped using the DREAD threat modeling approach, smaller organizations, Fortune 500 companies, and the military continue to use it. DREAD stands for:
  - D – Damage potential
  - R – Reproducibility
  - E – Exploitability
  - A – Affected users
  - D – Discoverability
- We rank these factors on a scale from 0-10 and calculate the sum of these values. If the resulting value is higher, the risk of a potential attack on the organization is greater and we need to employ mitigation strategies immediately.

## CVSS

- Common Vulnerability Scoring System é um padrão da indústria gratuito e aberto para avaliar a gravidade das vulnerabilidades de segurança do sistema de computador. O CVSS tenta atribuir pontuações de gravidade às vulnerabilidades, permitindo que os respondentes priorizem respostas e recursos de acordo com a ameaça.

## In the framework of the 4Cs of Cloud Native Security, which layer focuses on securing the infrastructure on which applications run, such as virtual machines, networks, and storage?

- Cloud Security
  > Cloud Security in the 4Cs framework refers to the protection of the underlying infrastructure used to run applications. This includes securing virtual machines, networks, storage, and other foundational components provided by the cloud provider.

## What is a critical security practice for the Kubernetes Controller Manager to ensure the integrity of the cluster’s control plane?

- Regularly updating the Controller Manager to the latest version
  > Regularly updating the Kubernetes Controller Manager to the latest version is a critical security practice. This ensures that the Controller Manager, a key component of the cluster's control plane, has the latest security patches and improvements. Keeping it updated helps protect against known vulnerabilities and exploits that could compromise the integrity of the cluster's control plane.

## Health Insurance Portability and Accountability Act

- A Lei de Portabilidade e Responsabilidade do Seguro Saúde de 1996 ( HIPAA ou Lei Kennedy – Kassebaum [1] [2] ) é uma Lei do Congresso dos Estados Unidos promulgada pelo 104º Congresso dos Estados Unidos e sancionada pelo Presidente Bill Clinton em 21 de agosto de 1996. [3] Ela visava alterar a transferência de informações de saúde, estipulava as diretrizes pelas quais as informações de identificação pessoal mantidas pelos setores de saúde e seguro saúde deveriam ser protegidas contra fraude e roubo, [4] e abordava algumas limitações na cobertura do seguro saúde . Ela geralmente proíbe provedores de saúde e empresas chamadas entidades cobertas de divulgar informações protegidas a qualquer pessoa que não seja um paciente e os representantes autorizados do paciente sem seu consentimento. O projeto de lei não restringe os pacientes de receber informações sobre si mesmos (com exceções limitadas). [5] Além disso, não proíbe os pacientes de compartilhar voluntariamente suas informações de saúde da maneira que escolherem, nem exige confidencialidade quando um paciente divulga informações médicas a familiares, amigos ou outros indivíduos que não sejam funcionários de uma entidade coberta. O ato é composto por 5 títulos:
  - O Título I protege a cobertura do seguro de saúde para os trabalhadores e suas famílias quando mudam ou perdem seus empregos. [6]
  - O Título II, conhecido como disposições de Simplificação Administrativa (AS), exige o estabelecimento de padrões nacionais para transações eletrônicas de - assistência médica e identificadores nacionais para provedores, planos de seguro saúde e empregadores. [7]
  - O Título III define diretrizes para contas de gastos médicos antes dos impostos.
  - O Título IV define diretrizes para planos de saúde de grupo.
  - O Título V rege as apólices de seguro de vida de propriedade da empresa.

## Common Vulnerability Scoring System

- O Common Vulnerability Scoring System ( CVSS ) é um padrão industrial gratuito e aberto para avaliar a gravidade das vulnerabilidades de segurança de sistemas de computador . O CVSS tenta atribuir pontuações de gravidade às vulnerabilidades, permitindo que os respondentes priorizem respostas e recursos de acordo com a ameaça. As pontuações são calculadas com base em uma fórmula que depende de várias métricas que aproximam a facilidade e o impacto de uma exploração. As pontuações variam de 0 a 10, sendo 10 a mais grave. Embora muitos usem apenas a pontuação base do CVSS para determinar a gravidade, também existem pontuações temporais e ambientais para levar em consideração a disponibilidade de mitigações e a extensão dos sistemas vulneráveis ​​dentro de uma organização, respectivamente. A versão atual do CVSS (CVSSv4.0) foi lançada em novembro de 2023. [1]

## O que é MITRE ATT&CK e como usar esse framework?

- O framework MITRE ATT&CK é um dos mais amplamente conhecidos e usados no mundo da cibersegurança. Na International IT, estamos comprometidos em fornecer serviços e soluções de alta qualidade em cibersegurança e TI, e reconhecemos a importância dessa estrutura em nossa abordagem.
- O MITRE ATT&CK é uma base de conhecimento de ameaças e ações mantida e desenvolvida pela MITRE Corporation em colaboração com a indústria e outros stakeholders. A MITRE Corporation é uma organização sem fins lucrativos financiada pelo governo federal dos EUA, encarregada de desenvolver soluções para manter os EUA seguros contra várias ameaças, incluindo as ameaças cibernéticas. O MITRE ATT&CK é um dos resultados desse trabalho e serve como base para identificar e construir proteções contra ameaças específicas de cibercriminosos.
- O nome ATT&CK é um acrônimo para Adversarial Tactics, Techniques and Common Knowledge. O MITRE ATT&CK está disponível gratuitamente para uso global por empresas privadas, governos ou fornecedores de soluções de cibersegurança.

## Cloud Native Security

- Not just cloud
- Think hybrid
- Azure Stack HCI, Google Anthos, EKS Anywhere, AWS Outposts
- Think of security as a whole

### Azure Stack HCI

- Run Kubernetes
- Azure Kubernetes services in your data center
- Like logging in to Azure

### Top 10 OWASAP for Kubernetes

> Ao adotar o Kubernetes, introduzimos novos riscos às nossas aplicações e infraestrutura. O OWASP Kubernetes Top 10 tem como objetivo ajudar profissionais de segurança, administradores de sistemas e desenvolvedores de software a priorizar riscos em torno do ecossistema Kubernetes. O Top Ten é uma lista priorizada desses riscos. No futuro, esperamos que isto seja apoiado por dados recolhidos de organizações que variam em maturidade e complexidade.

K01. Insecure Workload Configurations

```
apiVersion: v1
kind: Pod
metadata:
  name: root-user
spec:
  hostPID: true           ## Insecure Configurations
  hostIPC: true           ## Insecure Configurations
  hostUsers: true         ## Insecure Configurations
  hostNetwork: true       ## Insecure Configurations
  containers:
    - name: nginx
      image: nginx:1.14.2
      securityContext:
        privileged: true  ## Insecure Configurations
        #root user:
        #runAsUser: 0     ## Insecure Configurations
        #non-root user:
        #runAsUser: 5554
      volumeMounts:
        - mountPath: /host
          name: noderoot
  volumes:                ## Insecure Configurations
    - name: noderoot      ## Insecure Configurations
      hostPath:           ## Insecure Configurations
        path: /           ## Insecure Configurations
```

K02. Supply Chain Vulnerabilities

> Os contêineres assumem muitas formas em diferentes fases do ciclo de vida do desenvolvimento da cadeia de abastecimento; cada um deles apresentando desafios de segurança únicos. Um único contêiner pode contar com centenas de componentes e dependências de terceiros, tornando extremamente difícil a confiança na origem em cada fase. Esses desafios incluem, entre outros, integridade de imagem, composição de imagem e vulnerabilidades de software conhecidas.

- The in-toto Attestation Framework provides a specification for generating verifiable claims about any aspect of how a piece of software is produced. Consumers or users of software can then validate the origins of the software, and establish trust in its supply chain, using in-toto attestations.
  - ![The in-toto Attestation Framework](../../../imgs/envelope_relationships.png)
- Software Bill of Materials (SBOM): Two of the most popular open standards for SBOM generation include [CycloneDX](https://owasp.org/www-project-cyclonedx/) and [SPDX](https://github.com/opensbom-generator/spdx-sbom-generator).

- Image Signing: The open-source [Cosign](https://github.com/sigstore/cosign) project is an open source project aimed at verifying container images. Docker Content Trust is another option.

- Image Composition: Consider utilizing alternative base images such as Distroless or [Scratch](https://hub.docker.com/_/scratch) to not only improve security posture but also drastically reduce the noise generated by vulnerability scanners. Tools such as [Docker Slim](https://github.com/slimtoolkit/slim) are available to optimize your image footprint for performance and security reasons.

- Known Software Vulnerabilities: Open source tools such as Clair and trivy will statically analyze container images for known vulnerabilities such as CVEs and should be used as early in the development cycle as reasonably possible.

- Enforcing Policy: Prevent unapproved images from being used with the [Kubernetes admission controls](https://kubernetes.io/docs/reference/access-authn-authz/extensible-admission-controllers/) and policy engines such as [Open Policy Agent](https://www.openpolicyagent.org/) and [Kyverno](https://kyverno.io/) to reject workloads images which:
  - haven’t been scanned for vulnerabilities
  - use a base image that’s not explicitly allowed
  - don’t include an approved SBOM
  - originated from untrusted registries

K03. Overly Permissive RBAC Configurations

```
echo "Hello"
```

K04: Lack of Centralized Policy Enforcement

```
echo "Hello"
```

K05: Inadequate Logging and Monitoring

```
echo "Hello"
```

K06: Broken Authentication Mechanisms

```
echo "Hello"
```

K07: Missing Network Segmentation Controls

```
echo "Hello"
```

K08: Secrets Management Failures

```
echo "Hello"
```

K09: Misconfigured Cluster Components

```
echo "Hello"
```

K10: Outdated and Vulnerable Kubernetes Components

```
echo "Hello"
```

## Apply Pod Security Standards at the Cluster Level

```
mkdir -p /tmp/pss
cp ./cluster-config.yaml /tmp/pss
cp ./cluster-level-pss.yaml /tmp/pss
kind create cluster \
  --name psa-with-cluster-pss \
  --config /tmp/pss/cluster-config.yaml

kubectl apply -f example-baseline-pod.yaml
```

## Apply Pod Security Standards at the Namespace Level

```
kind create cluster --name psa-ns-level


docker exec -it psa-ns-level-control-plane bash -c "cat /sys/module/apparmor/parameters/enabled"

kubectl create ns example

kubectl label --overwrite ns example \
   pod-security.kubernetes.io/warn=baseline \
   pod-security.kubernetes.io/warn-version=latest

OR

kubectl label --overwrite ns example \
  pod-security.kubernetes.io/enforce=baseline \
  pod-security.kubernetes.io/enforce-version=latest \
  pod-security.kubernetes.io/warn=restricted \
  pod-security.kubernetes.io/warn-version=latest \
  pod-security.kubernetes.io/audit=restricted \
  pod-security.kubernetes.io/audit-version=latest

kubectl apply -n example -f https://k8s.io/examples/security/example-baseline-pod.yaml

```

## Restrict a Container's Access to Resources with AppArmor

Esta página mostra como carregar perfis do AppArmor em seus nós e impor esses perfis em Pods. Para saber mais sobre como o Kubernetes pode confinar Pods usando o AppArmor, consulte Restrições de segurança do kernel Linux para Pods e contêineres .

#### Objetivos

- Veja um exemplo de como carregar um perfil em um Node
- Aprenda como aplicar o perfil em um Pod
- Aprenda como verificar se o perfil está carregado
- Veja o que acontece quando um perfil é violado
- Veja o que acontece quando um perfil não pode ser carregado

#### Antes de você começar

```
docker exec -it kumabes-k8s-cluster-worker3 bash -c "cat /sys/module/apparmor/parameters/enabled"
docker exec -it kumabes-k8s-cluster-worker2 bash -c "cat /sys/module/apparmor/parameters/enabled"
docker exec -it kumabes-k8s-cluster-worker bash -c "cat /sys/module/apparmor/parameters/enabled"
docker exec -it kumabes-k8s-cluster-control-plane bash -c "cat /sys/module/apparmor/parameters/enabled"

# Install apparmor utilites in the kind cluster nodes
docker exec -it kumabes-k8s-cluster-control-plane bash -c "apt update && apt install apparmor-utils -y && systemctl restart containerd"
docker exec -it kumabes-k8s-cluster-worker bash -c "apt update && apt install apparmor-utils -y && systemctl restart containerd"
docker exec -it kumabes-k8s-cluster-worker2 bash -c "apt update && apt install apparmor-utils -y && systemctl restart containerd"
docker exec -it kumabes-k8s-cluster-worker3 bash -c "apt update && apt install apparmor-utils -y && systemctl restart containerd"


docker exec -it kumabes-k8s-cluster-worker3 bash -c "cat /sys/kernel/security/apparmor/profiles | sort"
docker exec -it kumabes-k8s-cluster-worker2 bash -c "cat /sys/kernel/security/apparmor/profiles | sort"
docker exec -it kumabes-k8s-cluster-worker bash -c "cat /sys/kernel/security/apparmor/profiles | sort"
docker exec -it kumabes-k8s-cluster-control-plane bash -c "cat /sys/kernel/security/apparmor/profiles | sort"

docker exec -it kumabes-k8s-cluster-control-plane bash -c "systemctl status apparmor"
docker exec -it kumabes-k8s-cluster-worker bash -c "systemctl status apparmor"
docker exec -it kumabes-k8s-cluster-worker2 bash -c "systemctl status apparmor"
docker exec -it kumabes-k8s-cluster-worker3 bash -c "systemctl status apparmor"


docker exec -it kumabes-k8s-cluster-control-plane bash -c "aa-status"
docker exec -it kumabes-k8s-cluster-worker bash -c "aa-status"
docker exec -it kumabes-k8s-cluster-worker2 bash -c "aa-status"
docker exec -it kumabes-k8s-cluster-worker3 bash -c "aa-status"

```

#### Protegendo um Pod

Os perfis do AppArmor podem ser especificados no nível do pod ou do container. O perfil do AppArmor do container tem precedência sobre o perfil do pod.

```

securityContext:
appArmorProfile:
type: <profile_type>

```

Onde <profile_type>está um dos seguintes:

- RuntimeDefault para usar o perfil padrão do tempo de execução
- Localhost para usar um perfil carregado no host (veja abaixo)
- Unconfined para rodar sem AppArmor

Para verificar se o perfil foi aplicado, você pode verificar se o processo raiz do contêiner está sendo executado com o perfil correto examinando seu proc attr:

```

kubectl exec nginx -- cat /proc/1/attr/current

```

#### Exemplo

#### Administração

##### Configurando nós com perfis

#### Perfis de autoria

#### Especificando o confinamento do AppArmor

##### Perfil do AppArmor dentro do contexto de segurança

[AppArmor](https://kubernetes.io/docs/tutorials/security/apparmor/)

```

kind create cluster \
 --config /media/rkumabe/DATA/git/rotoku/rotoku.github.io/content/pt-br/devops/kubernetes/kcsa/kind-cluster-config.yaml \
 --name kumabes-k8s-cluster

kind get clusters

kind delete clusters $(kind get clusters)

docker exec -it kumabes-k8s-cluster-control-plane bash -c "apt update && apt install apparmor-utils vim -y && systemctl restart containerd"
docker exec -it kumabes-k8s-cluster-worker bash -c "apt update && apt install apparmor-utils vim -y && systemctl restart containerd"
docker exec -it kumabes-k8s-cluster-worker2 bash -c "apt update && apt install apparmor-utils vim -y && systemctl restart containerd"
docker exec -it kumabes-k8s-cluster-worker3 bash -c "apt update && apt install apparmor-utils vim -y && systemctl restart containerd"

docker exec -it kumabes-k8s-cluster-control-plane bash -c "cat /sys/module/apparmor/parameters/enabled"
docker exec -it kumabes-k8s-cluster-control-plane bash -c "cat /sys/kernel/security/apparmor/profiles | sort"

```

## Restrict a Container's Syscalls with seccomp

```

kind create cluster \
 --config=/media/rkumabe/DATA/git/rotoku/rotoku.github.io/content/pt-br/devops/kubernetes/kcsa/seccomp-cluster-config.yaml \
 --name kumabes-k8s-cluster

docker container ps

docker exec -it kumabes-k8s-cluster-control-plane ls /var/lib/kubelet/seccomp/profiles
docker exec -it kumabes-k8s-cluster-worker ls /var/lib/kubelet/seccomp/profiles
docker exec -it kumabes-k8s-cluster-worker2 ls /var/lib/kubelet/seccomp/profiles
docker exec -it kumabes-k8s-cluster-worker3 ls /var/lib/kubelet/seccomp/profiles
kubectl apply -f pod-seccompprofile-runtimedefault.yamls

kubectl delete pod default-pod --wait --now

docker exec -it kumabes-k8s-cluster-worker2 bash
tail -f /var/log/syslog | grep http-echo

```

### O Admission Control funciona antes da autenticação e autorização? Depois autenticação e autorização ou depois da autenticação e antes da autorização?

- An admission controller is a piece of code that intercepts requests to the Kubernetes API server prior to persistence of the object, but after the request is authenticated and authorized.

### Qual é o componentes que precisa ser instalado sempre nos workers? Api server, kubelet e etc?

- kubelet
- kubeadm
- kubectl
- container runtime

### Qual é o componente que tem acesso ao etcd?

- By default all components that has access to etcd server and etcdctl installed;
- After configuring secure communication, restrict the access of the etcd cluster to only the Kubernetes API servers using TLS authentication.

### Explique todos acrônimos de stride?

| Threat                  | Property        | Definition                                               |
| ----------------------- | --------------- | -------------------------------------------------------- |
| Spoofing                | Authentication  | Impersonating something or someone else                  |
| Tampering               | Integrity       | Modifying data or code                                   |
| Repudiation             | Non-repudiation | Claiming to have not performed the action                |
| Information Disclosure  | Confidentiality | Exposing information to someone not authorized to see it |
| Denial of Service (DoS) | Availability    | Deny or degrade service to users                         |
| Elevation of Privilege  | Authorization   | Gain capabilities without proper authorization           |

### O que é convenção em todos cloud providers? Zero trust, share responsabilidade, mínimo privilégio

- Zero trust.

### Runtime lifecycle phase

The Runtime phase comprises three critical areas: compute, access, and storage.

### The four Cs of cloud native security

- Cloud (shared responsability model)
- Clusters
  - cloud layer
  - networking layer
  - infra layer
- Containers
  - conatiner vulnerability scanning and os dependency security
  - image signing and enforcement
  - disallowing privileged users
  - using container runtime with stronger isolation
- Code
  - access over tls only
  - limiting ranges of communication
  - third-party dependency security
  - static code analysis
  - dynamic probing attacks

### Cloud Provider Security

#### Azure

1. Azure security center
2. Azure AD
3. Built-In Registry

#### GCP

1. Security Dashboard
2. Out-of-the Box CIS
3. Policy Compliance

#### AWS

- https://aws.github.io/aws-eks-best-practices/security/docs/

### Kubernetes Isolation Overview

- Namespaces
- networking policies
- policy enforcement
- role-based access control (RBAC)

### Artifact and Image Repo Security Overview

- Docker Hub
- JFrog Artifactory

### Workload Security Overview

#### App Security Overview

- scanning code
- checking code
- ensuring that code in the image is secure

#### Top Five Tips for App Security

1. Scan Code
2. Scan the container image
3. Have an automated security tool
   - Kubescape
   - Aqua Security
   - kube-bench
4. Use proper RBAC
   - think least privilege from a permission perspection
5. Give containers what they need
   - OWASP Top 10
