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

codeql database create <database> --command <build> \
  --db-cluster --language=<language-identifier>,<language-identifier>
```

| Opção                       | Uso necessário                                                                                                                                                                                                                                                                                                                  |
| --------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| <database>                  | Especifique o nome e o local de um diretório a ser criado para o banco de dados CodeQL. O comando falhará se você tentar substituir um diretório. Se você também especificar --db-cluster, esse será o diretório pai e um subdiretório será criado para cada linguagem analisada.                                               |
| --language                  | Especifique o identificador do idioma para o qual será criado um banco de dados, um dos seguintes: cpp, csharp, go, java, javascript, python e ruby (use JavaScript para analisar o código TypeScript). Quando usado com --db-cluster, a opção aceita uma lista separada por vírgulas ou pode ser especificada mais de uma vez. |
| --command                   | Recomendável. Use para especificar o comando ou o script de build que invoca o processo de build para a base de código. Os comandos são executados da pasta atual ou, quando definidos, de --source-root. Não é necessário para a análise de Python e JavaScript/TypeScript.                                                    |
| --db-cluster                | Opcional. Use em bases de código de vários linguagens para gerar um banco de dados para cada linguagem especificada pelo --language.                                                                                                                                                                                            |
| --no-run-unnecessary-builds | Recomendável. Use para suprimir o comando de build para linguagens em que a CLI do CodeQL não precisa monitorar o build (por exemplo, Python e JavaScript/TypeScript).                                                                                                                                                          |
| --source-root               | Opcional. Use se você executa a CLI fora da raiz de check-out do repositório. Por padrão, o comando database create presume que o diretório atual é o diretório raiz para os arquivos de origem. Use essa opção para especificar outro local.                                                                                   |

### Há dois tipos importantes de consultas:

- As Consultas de Alerta destacam problemas em locais específicos de seu código.
- As Consultas de Caminho descrevem o fluxo de informações entre uma fonte e um coletor em seu código

```simple-query.ql
/**
 *
 * Query metadata
 *
 */
import /* ... CodeQL libraries or modules ... */
/* ... Optional, define CodeQL classes and predicates ... */
from /* ... variable declarations ... /
where / ... logical formula ... /
select / ... expressions ... */
```

### Sintaxe QL

> A sintaxe da QL é semelhante à do SQL, mas a semântica da QL é baseada no Datalog. Datalog é uma linguagem de programação lógica declarativa que é frequentemente usada como uma linguagem de consulta. Como a QL é principalmente uma linguagem lógica, todas as operações na QL são operações lógicas. A QL também herda predicados recursivos do Datalog. A QL adiciona suporte a agregações para tornar concisas e simples até mesmo as consultas complexas.

```Consultas de caminho
/**
 * ...
 * @kind path-problem
 * ...
 */

import <language>
// For some languages (Java/C++/Python/Swift), you need to explicitly import the data-flow library, such as
// import semmle.code.java.dataflow.DataFlow or import codeql.swift.dataflow.DataFlow
...

module Flow = DataFlow::Global<MyConfiguration>;
import Flow::PathGraph

from Flow::PathNode source, Flow::PathNode sink
where Flow::flowPath(source, sink)
select sink.getNode(), source, sink, "<message>"
```

## Code scanning with GitHub CodeQL

```qlpack.yml
name: codeql/java-queries
version: 0.0.6-dev
groups: java
suites: codeql-suites
extractor: java
defaultSuiteFile: codeql-suites/java-code-scanning.qls
dependencies:
    codeql/java-all: "*"
    codeql/suite-helpers: "*"
```

### A sintaxe QL

```
Person getADescendant(Person p) {
  result = p.getAChild() or
  result = getADescendant(p.getAChild())
}

int getNumberOfDescendants(Person p) {
  result = count(getADescendant(p))
}
```

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
