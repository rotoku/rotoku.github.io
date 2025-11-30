---
title: "GitOps"
linkTitle: "GitOps"
date: 2023-09-10
weight: 8
---

---------------
---------------
---------------

# GitOps
GitOps refers to an emerging set of principles, practices and tools which help you build an operational framework for cloud native applications primarily running on Kubernetes. It offers not only a developer-centric approach to deploy applications, but also brings in the familiar and effective workflows built around Git to the operations fold, such as rolling out with pull requests and rollbacks with git reverts.

GitOps provides a simple, fast, yet secure way to run operational activities on platforms such as Kubernetes, including continuous delivery, rolling out infrastructure components and policies, and a quick remediation in case of failure.

This course builds a conceptual foundation on GitOps by explaining the key principles, practices and the tools involved. By the end of this course, you should be familiar with the need for GitOps, learn about the two different reconciliation patterns and three different implementation options so that you could get started with your own GitOps journey with confidence.

## Tools
- Flux
- ArgoCD

## GitOps Principles
1. Declarative
A system managed by GitOps must have its desired state expressed declaratively.

2. Versioned and Immutable
Desired state is stored in a way that enforces immutability, versioning and retains a complete version history.

3. Pulled Automatically
Software agents automatically pull the desired state declarations from the source.

4. Continuously Reconciled
Software agents continuously observe actual system state and attempt to apply the desired state.

## GitOps Patterns
- CI/CD Controller
    - Conhece o estado de qualquer repositório (webhook ou através de algum evento)
    - exemplos: ArgoCD, Jenkins e TeamCity, e serviços de controlador, como Travis CI e CircleCI
    - o pipeline esta na ferramenta externa
- SCM Controller
    - No padrão SCM Controller, o código-fonte que controla a atividade de implantação de CI/CD é colocalizado no mesmo repositório Git que o código-fonte do aplicativo.
    - Exemplo: GitLab CI, GitHub Actions e BitBucket
    - o pipeline esta no próprio repositório

## Event-driven architecture for modern applications
### GAMES Architectural Patterns    
- GitOps (config-as-code)
- API
- Microservices
- Event-driven functions through a broker
- Shared Services Platform

## GitOps Architecture Explained
