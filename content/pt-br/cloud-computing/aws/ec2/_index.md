---
title: "EC2"
linkTitle: "EC2"
date: 2023-07-16
weight: 7
---

---------------
---------------
---------------

# EC2

EC2 é um IaaS
EC2 = Elastic Cloud Computing

## EC2 Placement Group
1. Cluster (High Performance)
2. Spread (Critical Group)
3. Partition (HDFS, HBase, Cassandra)

## EC2 shutdown behaviour & Termination Protection

## EC2 lunch troubleshooting
- .
- .
- .
    - .
    - .
    - .
    - .

## Instances Purchasing Options
- On-Demand Instances
    - billing per sencond, after the first minute
- Reserved (1 OR 3 years)
    - Up to 72% discount
    - Instance Type, Region, Tenancy, OS
    - Period
    - No Upfront/Partial Upfront/All Upfront
    - Regional or Zonal
    - Convertable
- Saving Plans (1 .. 3 years
    - Locked to specific family
- Spot Instances
    - Up to 90% discount
    - Instance that you can "lose"
- Dedicated Hosts
    - Complience
    - BYOL - Bring Your Own License
- Dedicated instances
- Capacity Reservations

01. Introdução ao Cloud Computing
- IaaS (Infra-Estrutura): criar máquinas, atualizar máquinas, deletar máquinas
- PaaS (Platform): aplicação weblogic, IIS, Apache
- SaaS (Softwares): google docs, drop box

02. Montando nosso primeiro ambiente no EC2
03. Escalando o banco de dados com RDS
04. Mais maquinas no EC2
05. Escalabilidade horizontal com Classic Load Balancer
06. Publicando versões diferentes com Application Load Balancer
07. Usando Sticky Session
- Sticky Session: cookie adicional para saber qual instância deve enviar as requisições.
- Balanceador por cliente;
08. Escalando EC2 automaticamente
09. Configurando o EC2 com o AWS CLI
```
aws ec2 run-instances --image-id ami-06767ea3972f81b10 --count 1 --instance-type t2.micro --key-name catalogo.pem --security-groups launch-wizard-1

aws ec2 run-instances --image-id ami-06767ea3972f81b10 --count 1 --instance-type t2.micro --key-name catalogo.pem --security-groups launch-wizard-1

aws elb create-load-balancer --load-balancer-name "aws-cli-lb" --listeners "Protocol=HTTP,LoadBalancerPort=80,InstanceProtocol=HTTP,InstancePort=8080" --availability-zones sa-east-1a sa-east-1c

aws elb register-instances-with-load-balancer --load-balancer-name "aws-cli-lb" --instances i-0f8f470386f0e2ddc i-0b1526f1c2abcbe05
```
### User Data
```
#!/bin/bash
export AWS_DEFAULT_REGION=sa-east-1
yum update -y && yum install httpd ntp wget curl git -y
timedatectl set-timezone America/Sao_Paulo
systemctl start httpd
systemctl enable httpd
echo "<h1>Hello World from `hostname`!</h1>" > /var/www/html/index.html
service ds_agent stop
chkconfig ds_agent off
```


### Useful commands
```
aws ec2 describe-instances
aws ec2 describe-instances --filters "Name=tag:Name,Values=prometheus-ubuntu" | jq -r '.Reservations[].Instances[].InstanceId'

aws ec2 start-instances --instance-ids $(aws ec2 describe-instances --filters "Name=tag:Name,Values=prometheus-ubuntu" | jq -r '.Reservations[].Instances[].InstanceId')
```