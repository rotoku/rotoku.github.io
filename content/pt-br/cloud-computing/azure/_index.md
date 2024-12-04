
---
title: "Azure"
date: 2023-07-16T11:46:56-03:00
weight: 2
---

---------
---------
---------

# Azure

[Onde estamos](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE4wyqh).

[Todas as certificações](https://query.prod.cms.rt.microsoft.com/cms/api/am/binary/RE2PjDI).

[Portal Azure](https://portal.azure.com/#home)


Métodos de acesso:
- console
- mobile
- cli
- sdk

```
az config set core.allow_broker=true
az account clear
az login --use-device-code
az account set --subscription <SUBSCRIPTION_ID>
az resource list
```

## Vantagens da Cloud Computing
- High Availability
- Scalability
- Agility
- Geo-distribution
- Disaster Recovery

## Why is cloud computing typically cheaper to use?
- Lower your operating costs;
- Run your infrastructure more efficiently;
- Scale as your business needs change;

## Cloud service Models
- SaaS
- PaaS
- IaaS

## What is serverless computing?
- Overlapping with PaaS, serverless computing enables developers to build applications faster by eliminating the need for them to manage infrastructure.

## Cloud Types
- On-premises/Private Cloud
- Hybrid
- Public Cloud

## De/Para AWS to Azure
- [Comparação entre os serviços do AWS e do Azure](https://learn.microsoft.com/pt-br/azure/architecture/aws-professional/services)
- [Comparação entre os serviços do AWS e do Azure](https://learn.microsoft.com/en/azure/architecture/aws-professional/services)

## Azure global infrastructure
- infra física e conexão de rede
- Geografia, regiões e zonas de disponibilidade
    - Availability Zone: are physically separate datacenters within an Azure region.
- [Azure geographies](https://azure.microsoft.com/en-us/explore/global-infrastructure/geographies/)

## Azure Marketplace
Recursos prontos de vários fábricantes, como por exemplo máquinas com sistemas operacionais pré-configurados (red hat, suse, windows server) ou então serviços como wordpress e etc.

## Azure Pricing
- Pricing by product
- Pricing calculator
- TCO calculator
- [Azure pricing](https://azure.microsoft.com/en-us/pricing/)

## Pay-as-you-go
- Pago pelo uso

## VMs - Payment Options
- Pay-As-You-Go
- Reserved virtual machine instances
- Spot Pricing

## Subscription
- Assinatura utilizada para provisionar nossos recursos na azure

## Resource Group
- Grupo de recursos: Gerenciar as tecnologias como bem enteder

## Azure Cost Management
- é possível gerenciar e verificar todos os recursos que estão sendo cobrados.

## Support
- Basic
- Developer
- Standard
- Professional Direct
- [Compare support plans](https://azure.microsoft.com/en-us/support/plans/)
- [Azure Q & A](https://learn.microsoft.com/en-us/answers/tags/133/azure)

## Azure CLI
The azure command-line interface is a set of commands used to create and manage Azure resources.
- (Instalando no Linux)[https://learn.microsoft.com/en-us/cli/azure/install-azure-cli-linux?pivots=apt]
- (azure-cli)[https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest]
- (Como instalar a CLI do Azure)[https://learn.microsoft.com/pt-br/cli/azure/install-azure-cli]

```
az config set core.allow_broker=true
az account clear
az login
```

## Criando uma VM via AZ CLI
```
az group list
az group create --location westus --resource-group labazcli
az vm create -n Ubuntu2204 -g labazcli --image Ubuntu2204 --ssh-key-values /home/rkumabe/.ssh/id_rsa.pub
az group delete --resource-group labazcli
```

## Compute Services
- Azure Virtual Machines
    - [Tamanhos das máquinas virtuais no Azure](https://learn.microsoft.com/pt-br/azure/virtual-machines/sizes)
    - Similar to AWS EC2
    - Virtual Machine scale sets
- Azure App Service
    - is an HTTP-based service for hosting web applications, REST APIs, and mobile back ends.
    - PaaS
    - Similar to AWS Beanstalk
- Azure Container Instances
    - Run docker containers on-demand in a managed, serverless Azure environment.
- Azure Kubernetes Service
    - AKS simplifies deploying a managed Kubernetes cluster in Azure by offloading much of the complexity and operational overhead to Azure.
- Windows Virtual Desktop
    - is a desktop and app virtualization service that runs on the cloud [windows 10, microsoft 365, windows 7 and RDS].
- Azure Functions
    - is a serverless solution that allows you to write less code, maintain less infrastructure, and save on costs.
    - [Conceitos de gatilhos e de associações do Azure Functions](https://learn.microsoft.com/pt-br/azure/azure-functions/functions-triggers-bindings?tabs=csharp)

## Networking Services
- Virtual Network
    - Address space
        - x.x.x.0
        - x.x.x.1
        - x.x.x.2
        - x.x.x.3
        - x.x.x.255
    - Subnets
    - Regions
    - Subscription
    - [Perguntas frequentes sobre a rede virtual do Azure (FAQ)](https://learn.microsoft.com/pt-br/azure/virtual-network/virtual-networks-faq)
- Load Balancer
    - similar NLB from AWS
    - operates at layer 4 of the OSI model. It's the single point of contact for clients.
    - kinds:
        - internal
        - public
- VPN Gateway
    - is a specific type of virtual network gateway that is used to send encrypted traffic between an Azure virtual network and an on-premises location over the public internet.
    - kinds:
        * site-to-site
        * multi-site
        * vnet(us-east) to vnet(us-west)
        * point to site (cliente com a azure)
        * [vpn gateway](https://learn.microsoft.com/pt-br/azure/vpn-gateway/design)
- Application Gateway
    - similar ALB from AWS
    - operates at layer 7
    - Can make routing decisions based on additional attributes of an HTTP request, for example URI path or host headers.
    - [Recursos do Gateway de Aplicativo do Azure](https://learn.microsoft.com/pt-br/azure/application-gateway/features)
- ExpressRoute
    - connections dont go over the public internet. This allow ExpressRoute connections offers more reliability, faster speeds, consistent latencies, and higher security than typical connections over the internet.
- Content Delivery Network
    - offers developers a global solution for rapidly delivering gigh-bandwidth content to users by caching their content strategically placed physical nodes across the world. (POPs - pontos de acessos da Azure)
    - concorrentes
        * verizon
        * akamai
    - [Azure CDN Coverage by Metro](https://learn.microsoft.com/en-us/azure/cdn/cdn-pop-locations)

## Storage Services
* Storage Account: **contains all of your Azure Storage data objects: blobs, files, queues, tables and disks.**
* Azure Storage redundancy:
    - Local Redundancy Storage
    - Zone Redundancy Storage
    - Geo Redundancy Storage
    - Geo-Zone Redundancy Storage
    - Read Access
- [Visão geral da conta de armazenamento](https://learn.microsoft.com/pt-br/azure/storage/common/storage-account-overview)
- [Armazenamento com redundância de zona](https://learn.microsoft.com/pt-br/azure/storage/common/storage-redundancy#zone-redundant-storage)   
- Blob: object storage solution for the cloud. Blob storage is optimized for storing massive amounts of unstructured data.
    - containers
    - file shared: offers fully managed file shares in the cloud that are accessible via industry standar Server Message Block (SMB) protocol or network file system (NFS).
    - tables
    - queues
- Disk: area block-level storage volumes that are managed by azure and used with azure virtual machines.
    * Kinds:
        - ultra disks
        - premium solid-state drives (SSD)
        - standards SSDs
        - standard hard disk drives (HDD)
    * [Tipos de disco gerenciado do Azure](https://learn.microsoft.com/pt-br/azure/virtual-machines/disks-types)    
```
sudo su -
lsblk
fdisk /dev/sdc
p
n
p
default
default
default
w
mkfs.xfs /dev/sdc1
mkdir /dados
mount /dev/sdc1 /dados
```     
- [Utilize o portal para anexar um disco de dados a uma VM Linux](https://learn.microsoft.com/pt-br/azure/virtual-machines/linux/attach-disk-portal?tabs=ubuntu)
- Access Tier:
    * Hot: accessed frequently
    * Cool: infrequently accessed and storage for at least 30 days
    * archive: rarely accessed and stored for a least 180 days.
    - Lifecycle Management: is possíble to configure rules for move files
## Database Services
- Cosmos DB
- Azure SQL
- MySQL
- PostgreSQL
- Database Migration Services

## Security Services
- Defense in Depth
    * is a military defensive strategy to secure a critical position using multiple defensive perimeter.    
    * Confidencialidade
    * Integridade
    * Availability (disponibilidade)
    * [What is defense in depth?](https://learn.microsoft.com/en-us/training/modules/secure-network-connectivity-azure/2-what-is-defense-in-depth)
- Security Azure Firewall
    * statefull similar security group
    * is a managed, cloud-based network security service that helps protect resources in your Azure virtual network.
    * [Recursos Standard do Firewall do Azure](https://learn.microsoft.com/pt-br/azure/firewall/features)
- Network Security Groups (NSG)
    * stateless similar NACL
    * enables you to filter network traffic to and from azure resources within an Azure virtual network.
    * [Visão geral da arquitetura do Firewall de Soluções de Virtualização de Rede do Azure](https://learn.microsoft.com/pt-br/azure/architecture/example-scenario/firewalls/)
- Azure DDoS Protection
    * uses the scale and elasticity of microsofts global network to bring DDoS mitigation capacity to Azure Region.
    * crowded concorrendo com um cliente real, pode topar o server ou derrubar o server
    * kinds:
        - Basic
        - Standard
    * [O que é a Proteção contra DDoS do Azure?](https://learn.microsoft.com/pt-br/azure/ddos-protection/ddos-protection-overview)
- Azure Defender
    * provides security alerts and advanced threat protection for virtual machines, sql databases, containers, web applications and etc.
    * [O que é o Microsoft Defender para Nuvem?](https://learn.microsoft.com/pt-br/azure/defender-for-cloud/defender-for-cloud-introduction)
- Azure Security Center
    * is unified infrastructure secutity management system that strengthens the security posture of your data centers, and providers advanced threat protection across your hybrid workloads in the cloud - whether they're in Azure or not - as well as on premises;
    * Painel para melhorias na azure [segurança, custo, excelencia operacional, compliance]    
    * []()
- Azure Key Vault
    * Secrets manager
    * key management
    * Certificate Management
    * Tiers:
        - Standard
        - Premium (HSM)
- Azure information Protection (AIP)
    * is a cloud-based solution that enables organizations to discover, classify, and protect documents and emails by applying labels to content.
- Advanced Threate Protection
    * offers built in threat protection functionality through services such Azure AD, Azure Monitor logs and security center
- **Azure Sentinel**
    * is scalable, cloud-native, security information event management (SIEM) and security orchestration automated response (SOAR) solution.
- Azure Dedicated Hosts
    * Provides physical servers

## Identity Services / Compliance
- Azure Active Directory
    * is the next evolution of identity and access management solutions for the cloud.
    * [Comparar o Active Directory ao Azure Active Directory](https://learn.microsoft.com/pt-br/azure/active-directory/fundamentals/compare)
- Single Sign-On
    * users sign in once with one account to access domain-joined devices, company resources, software as a service (SaaS) applications, and web applications.
    [Planejar uma implantação de logon único](https://learn.microsoft.com/pt-br/azure/active-directory/manage-apps/plan-sso-deployment)
- Multi-Factor Authentication
    * is a process where a user is prompted during the sign-in process for an additional form of identifcation, such as to enter a code on their cellphone or to provide a fingerprint scan.
- Azure Policy
    * helps to enforce organizational standards and to assess compliance at-scale.
- Azure RBAC
    *  role-based access control helps you manage who has access to Azure Resources.
- Azure Monitor
    *   
- Azure Health
    * [Service Trust Portal](https://servicetrust.microsoft.com/)
- Compliance
    * [Azure compliance documentation](https://learn.microsoft.com/en-us/azure/compliance/)

[Exame AZ-900: Fundamentos do Microsoft Azure](https://learn.microsoft.com/pt-br/certifications/exams/az-900/)