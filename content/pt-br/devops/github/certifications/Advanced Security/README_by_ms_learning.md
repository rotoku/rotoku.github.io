# GitHub Advanced Security

## Introduction to GitHub Advanced Security

- GHAS: O GitHub Advanced Security (ou GHAS) é uma solução de segurança de aplicativo que capacita os desenvolvedores.
- Secret scanning
- Code scanning
- Dependabot

## Configure Dependabot security updates on your GitHub repo

### GraphQL

```
query {
  repository(name: "${repo}", owner: "${org}") {
    vulnerabilityAlerts(first: 100) {
      nodes {
        createdAt
        dismissedAt
        securityVulnerability {
          package {
            name
          }
          severity
          vulnerableVersionRange
          advisory {
            ghsaId
            publishedAt
            identifiers {
              type
              value
            }
          }
        }
      }
    }
  }
}
```

## Configure and use secret scanning in your GitHub repository (26/06/2024)

> Observação
> Se houver mais de 1.000 entradas em paths-ignore, a verificação de segredo excluirá apenas os 1.000 primeiros diretórios das verificações.
> Se secret_scanning.yml for maior que 1 MB, a verificação de segredo ignorará o arquivo inteiro.

### Review secret scanning alerts:

- Ignorado / Bypassed
- Validade / Validity
- Tipo de segredo / Secret type
- Provedor / Provider

### Create a custom pattern

Para essas situações, você pode definir padrões personalizados de verificação de segredo em sua empresa, organização ou repositório privado. A verificação de segredo dá suporte a até 500 padrões personalizados para cada organização ou conta empresarial e até 100 padrões personalizados por repositório privado.

## Configure code scanning on GitHub (26/06/2024)

```
curl -L \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer ${GITHUB_TOKEN}" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/orgs/kumabes-org/code-scanning/alerts
```

> O upload do SARIF dá suporte a um máximo de 5.000 resultados por upload. Todos os resultados acima desse limite são ignorados. Se uma ferramenta gerar muitos resultados, você deverá atualizar a configuração para se concentrar nos resultados referentes às regras ou às consultas mais importantes.

> Cada upload do SARIF dá suporte a um máximo de 10 MB para o arquivo SARIF compactado gzip. Todos os uploads acima desse limite são rejeitados. Se o arquivo SARIF for muito grande porque contém muitos resultados, você deverá atualizar a configuração para se concentrar nos resultados das regras ou consultas mais importantes.

## Identify security vulnerabilities in your codebase by using CodeQL

- Preparação do banco de dados para CodeQL
- [Configuração da CLI](https://github.com/github/codeql-action/releases)

```
codeql resolve qlpacks
codeql resolve languages
```

### Criação do banco de dados

```
codeql database create <database> --language=<language-identifier>

codeql database create \
    /media/rkumabe/DATA/GitHub/database \
    --language=javascript
```

## Code scanning with GitHub CodeQL

-
-

## GitHub administration for GitHub Advanced Security

### Uma licença de GitHub Advanced Security fornece esses recursos para repositórios privados e internos:

- Verificação de código: detecta automaticamente vulnerabilidades e erros de codificação comuns.
- Verificação de segredo: recebe alertas quando segredos ou chaves são verificados, exclui arquivos da verificação e define até 100 padrões personalizados.
- Análise de dependência: mostra o efeito total das alterações nas dependências e exibe os detalhes de todas as versões vulneráveis antes de mesclar uma solicitação de pull.
- Visão Geral de Segurança: examina a configuração de segurança e os alertas de uma organização e identifica os repositórios com maior risco.

-

## Manage sensitive data and security policies within GitHub

-
-
