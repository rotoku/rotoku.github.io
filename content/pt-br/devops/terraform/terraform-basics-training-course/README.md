# Terraform Basics Training Course

## Types of IAC Tools
### Configuration Management
- Ansible
- puppet
- SaltStack


### Server Templating
- docker
- Packer
- Vagrant

### Provisioning Tools
- Terraform
- CloudFormation

## What is terraform?
Terraform é uma ferramenta de infraestrutura como código (IaC) desenvolvida pela HashiCorp. Ela permite definir, provisionar e gerenciar infraestrutura de forma automatizada e declarativa, utilizando arquivos de configuração em linguagem HCL (HashiCorp Configuration Language).

Com o Terraform, você pode criar, alterar e versionar recursos em provedores de nuvem como AWS, Azure, Google Cloud, além de serviços locais e SaaS. O Terraform compara o estado atual da infraestrutura com o desejado e aplica apenas as mudanças necessárias, garantindo consistência e reprodutibilidade.

Principais características:
- Provisão de recursos em múltiplos provedores.
- Controle de versionamento da infraestrutura.
- Automação de criação, alteração e destruição de recursos.
- Planejamento de mudanças antes da aplicação (terraform plan).

HCL: HashCorp Configuration Language

## O que é terraform.tfstate?

O arquivo **terraform.tfstate** é um arquivo gerado e mantido pelo Terraform que armazena o estado atual da infraestrutura gerenciada. Ele contém informações detalhadas sobre todos os recursos criados, modificados ou destruídos pelo Terraform, permitindo que a ferramenta saiba o que já existe e o que precisa ser alterado em execuções futuras.

Principais pontos:
- Serve como fonte de verdade para o Terraform sobre o ambiente provisionado.
- É fundamental para operações de atualização e destruição de recursos.
- Deve ser protegido, pois pode conter dados sensíveis.
- Pode ser armazenado localmente ou remotamente (ex: em um bucket S3) para trabalho em equipe e maior segurança.


## Install terraform
```bash
wget https://releases.hashicorp.com/terraform/1.4.0/terraform_1.4.0_linux_amd64.zip
unzip terraform_1.4.0_linux_amd64.zip
mv terraform /usr/local/bin
terraform version
```

## HCL Basics

```bash
<block> <parameters> {
    key1 = "value1"
    key2 = "value2"  
}
```
- block name
- resource type
- resource name
- arguments

### Steps:
```
terraform init
terraform validate
terraform plan
terraform apply
terraform show
terraform destroy
```

### Providers
- aws
- azure
- gcp
- github
- local

### lab #01
```local.tf
resource "local_file" "pet" {
    filename = "${path.module}/pet.txt"
    content  = "This is a local file created by Terraform."
    file_permission = "0700"
}
```

## Terraform basics
- registry.terraform.io
    - official:
        - aws
        - gcp
        - azure
        - local
    - partner:
        - f5
        - heroku
        - digitalocean
    - community:
        - activedirectory
        - ucloud
        - netapp-gcp    
### Files convention
main.tf:
Arquivo principal onde você define os recursos que serão criados, modificados ou destruídos pela infraestrutura. É onde ficam os blocos de recursos, módulos e a lógica principal do provisionamento.


- variables.tf: Arquivo usado para declarar variáveis de entrada do projeto. Aqui você define os nomes, tipos, descrições e valores padrão das variáveis que podem ser utilizadas em outros arquivos do Terraform.


- outputs.tf: Arquivo onde você especifica as saídas (outputs) do seu projeto Terraform. Essas saídas são valores que você deseja visualizar após a execução, como IPs, nomes de recursos, IDs, etc.

- provider.tf: Arquivo responsável por configurar os provedores de nuvem ou serviços que o Terraform irá utilizar (por exemplo, AWS, Azure, Google Cloud). Aqui você define qual provedor usar e suas credenciais/configurações básicas.

