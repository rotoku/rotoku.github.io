# Foundation

- https://learn.microsoft.com/en-us/collections/o1njfe825p602p

## SCM:
- Software/System Configuration Management
- Source Control Management
```
.git-empty
git add -A
git commit -am "feat: something new feature"

git log --oneline
```

## Contas
- Personal
    - publico ilimitado
    - privado limitado
- Organization
- Enterprise

## Planos
- GitHub grátis para contas pessoais e organizações
    Com GitHub Free, uma conta pessoal inclui:
        Suporte da comunidade GitHub
        Alertas de Dependabot
        Aplicação de autenticação de dois fatores
        500 MB de armazenamento de pacotes GitHub
        120 horas principais do GitHub Codespaces por mês
        15 GB de armazenamento GitHub Codespaces por mês
        Ações do GitHub:
            2.000 minutos por mês
        Regras de proteção de implantação para repositórios públicos

    Além dos recursos disponíveis no GitHub Free para contas pessoais, o GitHub Free para organizações inclui:
        Controles de acesso de equipe para gerenciamento de grupos

- GitHub Pro para contas pessoais
    As contas GitHub Pro incluem todos os recursos de uma conta GitHub Free, além dos seguintes recursos avançados:
        Suporte do GitHub por e-mail
        3.000 minutos de ações do GitHub por mês
        2 GB de armazenamento de pacotes GitHub
        180 horas principais do GitHub Codespaces por mês
        20 GB de armazenamento GitHub Codespaces por mês
        Ferramentas avançadas e insights em repositórios privados:
        Revisores de pull request obrigatórios
        Vários revisores de pull request
        Ramos protegidos
        Proprietários de código
        Referências vinculadas automaticamente
        Páginas do GitHub
        Wikis
        Gráficos de insights do repositório para pulso, contribuidores, tráfego, commits, frequência de código, rede e bifurcações

- Equipe GitHub
    Vejamos os recursos extras do GitHub Team que ajudam na colaboração em equipe:
        Suporte do GitHub por e-mail
        3.000 minutos de ações do GitHub por mês
        2 GB de armazenamento de pacotes GitHub
        Ferramentas avançadas e insights em repositórios privados:
            Revisores de pull request obrigatórios
            Vários revisores de pull request
            Rascunhos de solicitações pull
            Revisores de pull request da equipe
            Ramos protegidos
            Proprietários de código
            Lembretes programados
            Páginas do GitHub
            Wikis
        Gráficos de insights do repositório para pulso, contribuidores, tráfego, commits, frequência de código, rede e bifurcações
        A opção de ativar ou desativar GitHub Codespaces

- GitHub Enterprise
    Além dos recursos disponíveis no GitHub Team, GitHub Enterprise inclui:
        Suporte empresarial do GitHub
        Mais segurança, conformidade e controles de implantação
        Autenticação com logon único SAML
        Provisionamento de acesso com SAML ou SCIM
        Regras de proteção de implantação com GitHub Actions para repositórios privados ou internos GitHub Connect
        A opção de comprar GitHub Advanced Security

    Opções do GitHub Enterprise
    Existem duas opções diferentes do GitHub Enterprise:

    Servidor GitHub Enterprise
        GitHub Enterprise Cloud
        A diferença significativa entre GitHub Enterprise Server (GHES) e GitHub Enterprise Cloud é que GHES é uma solução auto-hospedada que permite que as organizações tenham controle total sobre sua infraestrutura.

        A outra diferença entre GHES e GitHub Enterprise Cloud é que GitHub Enterprise Cloud inclui um aumento dramático nos minutos de ações do GitHub e no armazenamento de pacotes do GitHub.

        Aqui estão os recursos adicionais do GitHub Enterprise Cloud:

        50.000 minutos de ações do GitHub por mês
        50 GB de armazenamento de pacotes GitHub
        Um acordo de nível de serviço para 99,9% de tempo de atividade mensal
        Opção para gerenciar centralmente políticas e cobranças para diversas organizações GitHub.com com uma conta corporativa
        Opção para provisionar e gerenciar contas de usuário para seus desenvolvedores, usando Enterprise Managed Users

## Formas de Acesso
- git command line
- web
- git mobile
- git desktop


## GitHub Copilot
o GitHub Copilot é desenvolvido com OpenAI Codex.
GitHub Copilot está disponível como uma extensão para:
- Visual Studio Code
- Visual Studio
- Vim/Neovim
- conjunto JetBrains de ambientes de desenvolvimento integrados (IDEs).

## Copiloto GitHub X
GitHub Copilot X é a visão para o futuro do desenvolvimento de software baseado em IA, adotando os mais novos modelos GPT-4 da OpenAI.
- Uma experiência semelhante ao ChatGPT em seu editor com GitHub Copilot Chat
- Copiloto para solicitações pull
- Respostas geradas por IA sobre documentação
- Copiloto para a interface de linha de comando (CLI)

### Planos
- Individual
- Business
- Enterprise


## GitHub Codespaces
é um ambiente de desenvolvimento totalmente configurado e hospedado na nuvem. Ao usar GitHub Codespaces, seu espaço de trabalho, juntamente com todos os seus ambientes de desenvolvimento configurados, ficam disponíveis em qualquer computador com acesso à Internet.

### O ciclo de vida do Codespace
- Creating a Codespace
Você pode criar um Codespace em GitHub.com, no Visual Studio Code ou pelo GitHub CLI. Existem quatro maneiras de criar um Codespace:

A partir de um modelo GitHub ou de qualquer repositório de modelos em GitHub.com para iniciar um novo projeto.
De uma ramificação em seu repositório para novos recursos funcionarem.
De uma solicitação pull aberta para explorar o trabalho em andamento.
De um commit no histórico de um repositório para investigar um bug em um momento específico.

abrir um codespace existente https://github.com/codespaces ou então pressionar . no repositorio
30 minutos de inatividade é deletedo o codespace


- Rebuilding a Codespace
- Stopping a Codespace
- Deleting a Codespace

Ao criar um Codespace GitHub, ocorrem quatro processos:

VM e armazenamento são atribuídos ao seu Codespace.
Um contêiner é criado.
Uma conexão com o Codespace é feita.
Uma configuração pós-criação é feita.


### Personalize seu codespace
### Codespaces versus editor GitHub.dev
Você provavelmente está se perguntando: quando devo usar GitHub Codespaces e quando devo usar GitHub.dev?

Você pode usar GitHub.dev para navegar em arquivos e repositórios de código-fonte do GitHub e fazer e confirmar alterações de código. Você pode abrir qualquer repositório, bifurcação ou pull request no editor GitHub.dev.

Se você quiser fazer um trabalho mais pesado, como testar seu código, use GitHub Codespaces. Ele possui computação associada para que você possa construir seu código, executá-lo e ter acesso ao terminal. GitHub.dev não contém computação. Com GitHub Codespaces, você obtém o poder de uma máquina virtual (VM) pessoal com acesso ao terminal, da mesma forma que usaria seu ambiente local, apenas na nuvem.

## Manage your work with GitHub Projects
### Introdução
### Projetos versus Projetos Clássicos
### Como criar um projeto
### Como organizar seu projeto
### Como organizar e automatizar seu projeto
### Insight e automação com projetos



## Communicate effectively on GitHub using Markdown
### Introdução
é uma linguagem de marcação leve que você pode usar para adicionar formatação a documentos. O Markdown é fácil de ler e escrever. Ele inclui convenções para várias linguagens de programação, como C#, Java, Python e Ruby. O Markdown também pode ser usado para formatar documentos de texto simples, como arquivos de leitura-me, comentários em problemas e solicitações pull e recursos de fórum de discussão.
### O que é o Markdown?
O Markdown é uma linguagem de markup que oferece uma abordagem magra à edição de conteúdos ao proteger os criadores de conteúdos da sobrecarga de HTML. Embora o HTML seja ótimo para compor conteúdo exatamente como foi planeado, ocupa muito espaço e pode ser difícil utilizá-lo, mesmo em pequenas doses. A invenção de Markdown permitiu obter um excelente equilíbrio entre a tecnologia do HTML relativamente à descrição de conteúdos e a facilidade do texto simples no que respeita à edição.
### GitHub-Flavored Markdown (GFM)

### Exemplos de Markdown
This is *italic* text.
This is also _italic_ text.

This is **bold** text.
This is also __bold__ text.

_This is **italic and bold** text_ using a single underscore for italic and double asterisks for bold.
__This is bold and *italic* text__ using double underscores for bold and single asterisks for italic.
<br />
***italic and bold***

\_Exemplo \*\*utilizando\*\* literais\_.

# Cabeçalho 1
## Cabeçalho 2
### Cabeçalho 3
#### Cabeçalho 4
##### Cabeçalho 5
###### Cabeçalho 6

![Link an image.](https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRRC1-4Sb24Or2oM1FScXmre8IQKcQSoQDqgLEwLceXcQ&s)

[Link to Microsoft Training](/training)

1. First
2. Second
3. Third

- First
  - Nested
- Second
- Third

First|Second
-|-
1|2
3|4

> Texto de citação.

Exemplo de<br />quebra de linha.

Isto é um `código`.

```markdown
var first = 1;
var second = 2;
var sum = first + second;
```

```javascript
var first = 1;
var second = 2;
var sum = first + second;
```

#### Cross-link issues and pull requests
A GFM suporta vários formatos de código abreviado para facilitar a ligação a problemas e pedidos Pull. A forma mais fácil de o fazer é ao utilizar o formato #ID, tal como #3602. O GitHub ajusta automaticamente ligações mais longas para este formato se as colar. Também pode seguir convenções adicionais, como se estiver a trabalhar com outras ferramentas ou quiser especificar outros projetos/ramos.

#### Link specific commits
Pode ligar a uma consolidação ao colar no respetivo ID ou simplesmente ao utilizar o algoritmo hash seguro (SHA).

#### Mention users and teams
Escrever um @ símbolo seguido de um nome de utilizador do GitHub envia uma notificação a essa pessoa sobre o comentário. Isto chama-se "@mention", porque está a mencionar o indivíduo. Também pode fazer @mention a equipas dentro de uma organização.

- [x] First task
- [x] Second task
- [ ] Third task

#### Slash commands
Os comandos de barra podem poupar-lhe tempo ao reduzir a escrita necessária para criar Markdown complexo.
Pode utilizar comandos de barra em qualquer campo de descrição ou comentário em issues, pull requests ou discussions em que esse comando de barra é suportado.

Comando|Descrição
-|-
/code|Insere um bloco de código Markdown. Selecione o idioma.
/details|Insere uma área de detalhes minimizável. Selecione o título e o conteúdo.
/saved-replies|Insere uma resposta guardada. Pode escolher uma das respostas guardadas para a sua conta de utilizador. Se adicionar %cursor% à resposta guardada, o comando de barra coloca o cursor nessa localização.
/table|Insere uma tabela markdown. Selecione o número de colunas e linhas.
/tasklist|Insere uma lista de tarefas. Este comando de barra só funciona numa descrição do problema.
/template|Mostra todos os modelos no repositório. Selecione o modelo a inserir. Este comando de barra funciona para modelos de problemas e um modelo de pedido Pull.

## Contribute to an open-source project on GitHub
### Introduction
### Identify where you can help
### Contribute to an open-source repository
LICENSE: O projeto deve conter uma licença de código aberto. Se o projeto não tiver uma licença, não é open source.
README: O arquivo LEIA-ME geralmente serve como a página de boas-vindas para o projeto. Ele geralmente fornece informações sobre como começar a usar o projeto. Também é comum que inclua informações sobre como interagir com a comunidade.
CONTRIBUTING: Como o próprio nome sugere, este documento fornece orientações sobre como contribuir para o projeto. Ele geralmente descreve como o processo de contribuição funciona e inclui detalhes sobre como configurar seu ambiente de desenvolvimento.
CODE_OF_CONDUCT: O código de conduta estabelece regras básicas para os membros da comunidade. Ao fazê-lo, ajuda a tornar a comunidade um ambiente seguro e acolhedor para todas as pessoas.

https://github.com/jupyter/notebook/contribute
Irá reparar que a maioria dos problemas apresentados no URL contribute têm etiquetas, como good-first-issue, help wanted, beginner-friendly e assim sucessivamente. As etiquetas são frequentemente utilizadas para fornecer informações de nível superior sobre o problema e o tipo de ajuda necessária.


### Exercise - Create your first pull request
https://github.com/firstcontributions/first-contributions

Bug (vermelho): Algo não está funcionando
Documentação (azul): Melhorias ou adições à documentação
Duplicado (cinza): esse problema ou solicitação pull já existe
Aprimoramento (azul): novo recurso ou solicitação

Não inscrito: Receba notificações apenas quando tiver participado ou tiver participado @mentioned
Assinado: Receba todas as notificações para este pull request
Personalizado: seja notificado apenas para os eventos selecionados

### Next steps
- https://docs.github.com/en/get-started/exploring-projects-on-github
- https://docs.github.com/en/apps/github-marketplace/github-marketplace-overview/about-github-marketplace-for-apps
- https://github.com/marketplace
- https://docs.github.com/en/get-started/exploring-projects-on-github/finding-ways-to-contribute-to-open-source-on-github
- https://github.com/topics/actions
- https://github.com/sdras/awesome-actions
- https://github.com/sdras/awesome-actions/graphs/contributors
### Knowledge check
### Summary

## Manage an InnerSource program by using GitHub
### Introduction
### How to manage a successful InnerSource program
- https://resources.github.com/whitepapers/introduction-to-innersource/
- https://github.com/matiassingers/awesome-readme
- https://github.com/mntnr/awesome-contributing
- https://github.com/devspace/awesome-github-templates
- https://docs.github.com/en/get-started/using-github/github-flow
- https://learn.microsoft.com/pt-pt/azure/devops/repos/git/git-branching-guidance?view=azure-devops
- https://gist.github.com/githubteacher/9fe53687a5f173d1d64c24c68625349e
- https://github.com/orgs/community/discussions/
- https://github.com/ideaconsult/etc/wiki/IDEA-Development-Collaboration-Best-Practices
- https://resources.github.com/innersource/fundamentals/
- https://support.github.com/
- https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories
- https://githubtraining.github.io/innersource-theory/#/
### Knowledge check
### Summary

## Maintain a secure repository by using GitHub best practices
### Introduction

### How to maintain a secure GitHub repository
Na guia Segurança, você pode adicionar recursos ao fluxo de trabalho do GitHub para ajudar a evitar vulnerabilidades no repositório e na base de código. Esses recursos incluem:

Políticas de segurança que permitem especificar como relatar uma vulnerabilidade de segurança em seu projeto adicionando um arquivo SECURITY.md ao repositório.
Alertas do Dependabot que notificam quando o GitHub detecta que seu repositório está usando uma dependência vulnerável ou malware.
Avisos de segurança que você pode usar para discutir, corrigir e publicar informações de maneira privada sobre vulnerabilidades de segurança em seu repositório.
Digitalização de código que ajuda você a encontrar, fazer triagem e corrigir vulnerabilidades e erros em seu código.

- https://docs.github.com/en/code-security/getting-started/adding-a-security-policy-to-your-repository
- https://docs.github.com/en/code-security/security-advisories/working-with-repository-security-advisories/about-repository-security-advisories
- https://docs.github.com/get-started/getting-started-with-git/ignoring-files
- https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository
- https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-protected-branches/managing-a-branch-protection-rule
- https://docs.github.com/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/about-code-owners#codeowners-syntax
### Exercise - Add a .gitignore file
### Automated security
- https://docs.github.com/en/code-security/code-scanning/introduction-to-code-scanning/about-code-scanning#about-code-scanning
- https://docs.github.com/en/code-security/secret-scanning/about-secret-scanning
- https://docs.github.com/en/code-security/dependabot/dependabot-security-updates/configuring-dependabot-security-updates
- https://docs.github.com/en/code-security/security-advisories/working-with-repository-security-advisories/about-repository-security-advisories#dependabot-alerts-for-published-security-advisories
- https://docs.github.com/en/code-security/dependabot/dependabot-alerts/about-dependabot-alerts#dependabot-alerts-for-vulnerable-dependencies
- https://docs.github.com/en/code-security/supply-chain-security/understanding-your-software-supply-chain/about-the-dependency-graph

### Knowledge check
### Summary


## Introduction to GitHub administration

## Authenticate and authorize user identities on GitHub
O que é o git blame?
Apesar de seu nome ameaçador, git blame é um comando que exibe o histórico de commit de um arquivo. Ele facilita a visualização de quem fez as alterações e quando. Isso facilita muito rastrear outras pessoas que trabalharam em um arquivo a fim de buscar a contribuição ou a participação delas.

https://docs.github.com/en/get-started/writing-on-github/working-with-advanced-formatting/autolinked-references-and-urls


## Manage repository changes by using pull requests on GitHub
## Search and organize repository history by using GitHub
