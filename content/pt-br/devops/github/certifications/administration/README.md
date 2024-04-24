# [GitHub Administration](https://learn.microsoft.com/en-us/collections/mom7u1gzjdxw03)

1. Introduction to GitHub administration
- Introduction
- What is GitHub administration?
- How does GitHub authentication work?
    - USER and PASSWORD
    - PAT
    - SSH
    - DEPLOY KEYS
    - GitHub's added security options
        - Two-factor authentication, somente com a opção de usuário e senha
    - SAML(Security Assertion Markup Language) SSO(single sign-on) (organization and enterprise)
        - Active Directory Federation Services (AD FS)
        - Microsoft Entra ID
        - Okta
        - OneLogin
        - PingOne
    - LDAP (GitHub Enterprise Server)
        - Active Directory
        - Oracle Directory Server Enterprise Edition
        - OpenLDAP
        - Open Directory
- How does GitHub organization and permissions work?
    - Repository permissions
        - Read
        - Triage (issue, pr's)
        - Write
        - Maintain
        - Admin
    - Team permissions
        - Member
        - Maintainer
    - Organization permissions
        - Owner
        - Member
        - [Moderator](https://docs.github.com/en/organizations/managing-peoples-access-to-your-organization-with-roles/managing-moderators-in-your-organization)
        - [Billing manager](https://docs.github.com/en/organizations/managing-peoples-access-to-your-organization-with-roles/adding-a-billing-manager-to-your-organization)
        - [Security managers](https://docs.github.com/en/organizations/managing-peoples-access-to-your-organization-with-roles/managing-security-managers-in-your-organization)
        - [Outside collaborator](https://docs.github.com/en/organizations/managing-user-access-to-your-organizations-repositories/managing-outside-collaborators/adding-outside-collaborators-to-repositories-in-your-organization)
    - Enterprise permissions
        - Owner
        - Member
        - Billing manager
    - Repository security and management
        - Create protection rules
        - Add a CODEOWNERS file
            - root
            - docs
            -.github
        - View traffic by using Insights    
- Knowledge check
- Summary

2. Introduction to GitHub's products
    - Introduction
    - GitHub accounts and plans
        - Tipos de conta do GitHub:
            - Personal
            - Organization
            - Enterprise
        - Planos do GitHub
            - GitHub Free for personal accounts and organizations
            - GitHub Pro for personal accounts
            - GitHub Team
            - GitHub Enterprise        
    - GitHub Mobile and GitHub Desktop
        - With GitHub Mobile you can:
            - Manage, triage, and clear notifications from github.com.
            - Read, review, and collaborate on issues and pull requests.
            - Edit files in pull requests.
            - Search for, browse, and interact with users, repositories, and organizations.
            - Receive a push notification when someone mentions your username.
            - Schedule push notifications for specific custom hours.
            - Secure your GitHub.com account with two-factor authentication.
            - Verify your sign in attempts on unrecognized devices.
        - With GitHub Desktop:
            - Add and clone repositories.
            - Add changes to your commit interactively.
            - Quickly add co-authors to your commit.
            - Check out branches with pull requests and view CI statuses.
            - Compare changed images.            
    - GitHub billing
        - Subscriptions include your account's plan, such as GitHub Pro or GitHub Team, as well as paid products that have a consistent monthly cost, such as GitHub Copilot and apps from GitHub Marketplace.
        - Usage-based billing applies when the cost of a paid product depends on how much you use the product. For example, the cost of GitHub Actions depends on how many minutes your jobs spend running and how much storage your artifacts use.

    - Knowledge check

    - Summary

3. Maintain a secure repository by using GitHub best practices
    - Introduction

    - How to maintain a secure GitHub repository
        - Security policies
        - Dependabot alerts
        - Security advisories
        - Code scanning 

        > Você pode criar o arquivo CODEOWNERS na raiz do repositório ou nas pastas docs ou .github
    - Exercise - Add a .gitignore file

    - Automated security

    - Knowledge check

    - Summary

4. Manage sensitive data and security policies within GitHub
    - Introduction

    - Setting security policies
        - CODE_OF_CONDUCT.md
        - CONTRIBUTING.md
        - FUNDING.yml
        - Modelos de problema e de solicitação de pull e config.yml
        - SECURITY.md
        - SUPPORT.md

        > A prioridade é para os arquivos que estão na pasta .github


    - Scrub sensitive data from a repository
        Alguns dos ganchos de pré-commit mais populares que atendem a essa finalidade incluem:
        - Gitleaks
        - plug-ins de pré-commit:
            - detect-aws-credentials
            - detect-private-key
            - secrets_filename

        Remoção de arquivos do repositório: git filter-repo 
        Usar a ferramenta [BFG Repo-Cleaner](https://rtyley.github.io/bfg-repo-cleaner/)
        Para remover o arquivo que contém dados confidenciais e deixar o último commit inalterado, execute:
        ```
        bfg --delete-files YOUR-FILE-WITH-SENSITIVE-DATA
        ```
        Para substituir todo o texto listado em passwords.txt em todas as ocorrências no histórico do repositório, execute:
        ```
        bfg --replace-text passwords.txt
        ```
        Depois que os dados confidenciais são removidos, você precisa forçar o push das alterações para o GitHub.
        ```
        $ git push --force
        ```

        > Usar a ferramenta git filter-repo Ao executar git filter-repo após o stash das alterações, você não poderá recuperar as alterações com outros comandos stash. Antes de executar git filter-repo, é recomendado cancelar o stash das alterações feitas. Para cancelar o stash do último conjunto de alterações com stash, execute git stash show -p | git apply -R



    - Reporting and logging
        Você pode acessar o log de auditoria por meio do GitHub.com, do GitHub Enterprise Server ou do GitHub AE para conferir as ações dos últimos 90 dias. 
        A API GraphQL está disponível para organizações que usam o GitHub Enterprise e pode recuperar informações sobre ações com até 120 dias. Ela monitora:
        A API REST está disponível para organizações que usam o GitHub Enterprise Cloud e pode recuperar informações sobre ações ocorridas durante um período de até 90 dias. Ela monitora as mesmas ações que a API GraphQL e também os eventos do Git. No entanto, as informações sobre eventos do Git ficam no log por apenas sete dias.        

|Qualificador|Valor de exemplo|
|---|---|
|action|team.create|
|actor|octocat|
|user|codertocat|
|org|octo-org|
|repo|octo-org/documentation|
|created|2019-06-01|

    - Exercise

    - Knowledge check

    - Summary

5. Authenticate and authorize user identities on GitHub
    - Introduction

    - User identity and access management

    - User authentication

    - User authorization

    - Team synchronization

    - Knowledge check

    - Summary

6. GitHub administration for enterprise support and adoption
    - Introduction

    - GitHub Enterprise features

    - Support for GitHub Enterprise

    - Scale your enterprise deployment

    - GitHub Enterprise Managed Users

    - Knowledge check

    - Summary

7. Manage GitHub Actions in the enterprise
    - Introduction

    - Manage actions and workflows

    - Manage runners
```
#Download
## Create a folder
mkdir actions-runner && cd actions-runner

## Download the latest runner package
curl -o actions-runner-linux-x64-2.314.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.314.1/actions-runner-linux-x64-2.314.1.tar.gz

## Optional: Validate the hash
echo "6c726a118bbe02cd32e222f890e1e476567bf299353a96886ba75b423c1137b5  actions-runner-linux-x64-2.314.1.tar.gz" | shasum -a 256 -c

## Extract the installer
tar xzf ./actions-runner-linux-x64-2.314.1.tar.gz

## Configure
### Create the runner and start the configuration experience
./config.sh --url https://github.com/kumabes-org --token 123456789 --labels x64,linux,github-runner

# Last step, run it!
sudo ./svc.sh install ec2-user
sudo ./svc.sh start
sudo ./svc.sh status
```

Servidores proxy
Caso precise de um executor auto-hospedado para se comunicar com o GitHub por meio de um servidor proxy, o Enterprise Cloud e o Enterprise Server permitirão que você altere as configurações de proxy usando as seguintes variáveis de ambiente:

Variável de ambiente	Descrição
https_proxy	URL de proxy para tráfego HTTPS. Também é possível incluir credenciais de autenticação básicas, se necessário. Por exemplo:
http://proxy.local
http://192.168.1.1:8080
http://username:password@proxy.local
http_proxy	URL de proxy para tráfego HTTP. Também é possível incluir credenciais de autenticação básicas, se necessário. Por exemplo:
http://proxy.local
http://192.168.1.1:8080
http://username:password@proxy.local
no_proxy	Lista separada por vírgulas de hosts que não devem usar um proxy. Somente os nomes de host são permitidos no no_proxy, você não pode usar endereços IP. Por exemplo:
example.com
example.com,myserver.local:443,example.org


    - Manage encrypted secrets

    - Exercise - Use a repository secret in a GitHub Actions workflow

    - Knowledge check

    - Summary

8. Leverage GitHub Actions to publish to GitHub Packages
    - Introduction

    - What is GitHub Packages?
        - npm
        - NuGet
        - Maven/Gradle
        - RubyGems
        - containers

    - Publish to GitHub Packages and GitHub Container Registry
```
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
docker tag IMAGE_ID ghcr.io/OWNER/IMAGE_NAME:latest
docker push ghcr.io/OWNER/IMAGE_NAME:latest
```
    - Knowledge check

    - Exercise - Publish to a GitHub Packages registry

    - GitHub Packages for code packages

    - Knowledge check

    - Summary