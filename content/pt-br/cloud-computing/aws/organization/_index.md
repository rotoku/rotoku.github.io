---
title: "Organization"
linkTitle: "Organization"
date: 2025-05-09
weight: 19
---

---------------
---------------
---------------

# AWS Organizations

O **AWS Organizations** é um serviço que permite gerenciar várias contas da AWS de forma centralizada. Ele é ideal para empresas que precisam organizar e controlar o acesso a recursos em diferentes contas.

Land Zone, Foundation, Base: A mesma coisa, como você vai estruturar suas contas na AWS.

## Estrutura de Contas

- **Conta Raiz (Root Account)**: A conta principal que gerencia a organização.
- **Unidades Organizacionais (OUs)**: Grupos de contas que compartilham políticas semelhantes.
- **Contas Membro**: Contas individuais que pertencem à organização.

### Exemplo de Estrutura

```plaintext
Root Account
├── OU: Desenvolvimento
│   ├── Conta: Dev-Team1
│   ├── Conta: Dev-Team2
├── OU: Produção
│   ├── Conta: Prod-App1
│   ├── Conta: Prod-App2
└── OU: Segurança
    ├── Conta: Logs
    ├── Conta: Auditoria
```    