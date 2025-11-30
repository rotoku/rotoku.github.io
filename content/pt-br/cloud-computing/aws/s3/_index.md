---
title: "S3"
linkTitle: "S3"
date: 2023-07-16
weight: 10
---

---------------
---------------
---------------

# S3

AWS Simple Storage Service S3

### criando um novo bucket
```
aws s3 mb s3://rotoku-images
```
### forçando remoção do bucket com conteúdo
```
aws s3 rb s3://rotoku-s3 --force
```
### download conteúdo s3
```
aws s3 cp s3://rotoku-s3/teste.txt
```
### upload conteúdo s3
```
aws s3 cp teste.txt s3://rotoku-s3
```
### remove o objeto no bucket
```
aws s3 rm s3://rotoku-s3/teste.txt
```
### renomear ou mover
```
aws s3 mv s3://rotoku-s3/teste.txt s3://rotoku-s3/testando.txt
```
### sincronizar o ambiente remoto com o local
```
aws s3 sync s3://rotoku-s3 rotoku-s3
```
### sincronizar o ambiente local com o remoto
```
aws s3 sync . s3://rotoku-s3
```
### sincronizar o ambiente local com o remoto (arquivos excluídos locais)
```
aws s3 sync . s3://rotoku-s3 --delete
```
> Its possible to enable bucket versioning, by default its came disabled

### S3 Storage Classes
- Amazon S3 Standard - General Purpose
- Amazon S3 Standard-Infrequent Access (IA)
- Amazon S3 One Zone-Infrequent Access
- Amazon S3 Glacier Instant Retrieval
    - minimum storage duration 90 days
- Amazon S3 Glacier Flexible Retrieval
    - minimum storage duration 90 days
- Amazon S3 Glacier Deep Archive
    - Standard 12 hours
    - Bulk 48 hours
    - minimum storage duration 180 days
- Amazon S3 Intelligent Tiering
    - auto-tiering fee
    - moves objects automatically
> Can move between classes manually or using S3 Lifecycle configurations

- esta relacionado ao custo e ao armazenamento
Standard		= -
### Arquivo de backup e arquivo de versões
- Standard IA
    - tamanho minimo 128KB, duração minima de 30 dias, taxa de recuperação por GB;
- Amazon Glacier:
    - low-cost object storage meant for archiving/backup
    - data is retained for the longer term (10s of years)
    - alternative to on-oremises magnetic tape storage
    - average annual durability is 99,999999999%
    - cost per storage per month ($0.004 / GB - Standard | $0.00099 / GB Deep Archive)
    - each item is called archive up to 40TB
    - instead bucket is called vault
    - operations:
        - upload
        - download
        - delete
    - duração minima de 90 dias, latência do primeiro byte minutos/horas, taxa de recuperação por GB;
    - Vault policies & Vault lock

- Fator financeiro
Standard		= +R$
Standard IA		= +-R$
Amazon Glacier	= -R$ (não esta implementado no brasil)

- Life Cycle Policy (é possível ao passar do tempo transitar o classe de persistência)

					Standard	Standard_IA		Amazon_Glacier
Primeiros 50 TB		$0,0215		$0,00152		$0,0005


> bucket-name.s3-website-aws-region.amazonaws.com
> OR
> bucket-name.s3-website.aws-region.amazonaws.com
> Example:
> http://website-kumabe.s3-website-sa-east-1.amazonaws.com/
> http://website-kumabe.s3-website.sa-east-1.amazonaws.com/


### Kinds of Replication
- Cross Region Replication
- Same Region Replication


### Multi-part Upload
- recommended when the file has > 100MB
- must use for files > 5GB
- using sdk or aws cli to upload
- max parts: 10000
- its possible to configure lifecycle to multipart

```
aws s3 mb s3://$BUCKET_NAME

split -b 35m <FILE> <FILE>_part_
aw3 s3api create-multipart-upload --bucket $BUCKET_NAME --key <FILE>
UPLOAD_ID=$(cat create-multipart-upload.json | jq .UploadId | sed "s/\"//g")

aws s3api list-multipart-uploads --bucket $BUCKET_NAME

aws s3api upload-part --bucket $BUCKET_NAME --key <FILE> --part-number 1 --body part01 --upload-id ${UPLOAD_ID}

aws s3api list-parts --upload-id ${UPLOAD_ID} --bucket $BUCKET_NAME --key <FILE>

aws s3api complete-multipart-upload --multipart-upload file://mpustruct --bucket my-bucket --key 'multipart/01' --upload-id dfRtDYU0WWCCcH43C3WFbkRONycyCpTJJvxu2i5GYkZljF.Yxwh6XG7WfS2vC4to6HiV6Yjlx.cph0gtNBtJ8P3URCSbB7rjxI5iEwVDmgaXZOGgkk5nVTW16HOQ5l0R


```

### Athena and S3
Solution Serverless to get analytics from bucket s3
```

```

### S3 Select & Glacier Select
- performing server-side filtering

### S3 Batch operations
- Perform bulk operations
- encrypt un-encrypted objects
- modidy ACLS, tags
- You can use s3 inventory to get object list and use s3 select to filter your objects

### S3 inventory
- list objects and their corresponding metadata (alternative to s3 list API operation)
- Usage examples:
    - audit and report on the replication and encryption status of your objects
    - get the number of objects in an s3 bucket
    - Identify the total storage of previus object versions
- Management tabs    

### Object Encryption
- Server Side S3-S3: AES-256, Must set header "x-amz-server-side-encryption": "AES256"
- Server Side S3-KMS: Must set header "x-amz-server-side-encryption": "aws:kms"
    - you me be impacted by KMS limits
    - upload: GenerateDataKey KMS API
    - download: Decrypt KMS API
    - KMS quota per second (5500, 10000, 30000 req/s based region)
    - Its possible to increase soft limit
- Server Side S3-C: using keys fully managed by the customer outside of aws
    - its not enable to web interface, just via aws cli, aws sdk or s3 rest api
- Client Side Encryption: use client libraries
    - clients must encrypt
    - clients must decrypt
    - customer fully manages the keys

### Default Encryption vs Bucket Policies
```json
Condition: {
    "Null": {
        Encrypted: true
    }
}
```

### S3 CORS
- enable static website
- turn bucket public
- add policy

```json
[
    {
        "AllowedHeaders": [
            "Authorization"
        ],
        "AllowedMethods": [
            "GET"
        ],
        "AllowedOrigins": [
            "http://www.example1.com"
        ],
        "ExposeHeaders": [],
        "MaxAgeSeconds": 3000
    }
]
```

### Pre-Signed URL's
- URL Expiration:
    - S3 Console: 1 min up to 720 mins (12 hours)
    - AWS CLI: "--expires-in", default 3600 secs, max 604800 secs ~168 hours


### S3 Object Lock (versioning must be enabled)    
- Retention Mode - Compliance
- Retention Mode - Governance
- Retention Period
- Legal Hold

### S3 - Access Points
Gerencie com facilidade o acesso a conjuntos de dados compartilhados no Amazon S3

Os clientes usam cada vez mais o Amazon S3 para armazenar conjuntos de dados compartilhados, em que os dados são agregados e acessados por diferentes aplicações, equipes e indivíduos, seja para análise, machine learning, monitoramento em tempo real ou outros casos de uso do data lake. Gerenciar o acesso a este bucket compartilhado requer uma única política de bucket que controla o acesso para dezenas a centenas de aplicações com diferentes níveis de permissão. À medida que um conjunto de aplicativos cresce, a política de bucket se torna mais complexa, demorada para gerenciar e precisa ser auditada para garantir que as alterações não tenham um impacto inesperado em outro aplicativo.

Configure Access Point
Configure Bucket Policy
- Finance Group
- Sales Group
- Analytics Group

### S3 - Multi-Region Access Points
- Provider a global endpoint that span S3 buckets in multiple AWS regions
- Dynamically route requests to the nearest S3 bucket (lowest latency)
- Bi-directional S3 bucket replication rules are created to keep data in sync across regions
- Failover Controls - allows you to shift requests acroos s3 buckets in different AWS regions within minutes (Active-Active or Active-Passive)

### S3 - VPC Endpoint Gateway for S3
- from public instance access s3
- from private instance acess vpc endpoit gateway and acess s3