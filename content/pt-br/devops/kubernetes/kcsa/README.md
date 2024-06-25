# Kubernetes and Cloud Native Security Associate (KCSA)

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
