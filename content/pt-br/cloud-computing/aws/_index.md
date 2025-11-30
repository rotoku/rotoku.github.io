
---
title: "AWS"
date: 2023-07-16T11:46:56-03:00
weight: 1
---

---------
---------
---------

## SAM

- Transform section

- Basic steps
    - build
    - package
    - deploy
## Security & Encryption
## Encryption in flight (SSL)
- data is encrypted before sending and decrypted after receiving
- SSL certificates help with encryption (HTTPS)
- Encryption in glight ensures no MITM can happen

## Server Side Encryption at rest
- data is encrypt after being received by the server
- data is decrypt before being sent
- It is stored in an encrypted form thanks to a key
- The encrypt/decrypt keys must be managed somewhere and the server must have access to it

## Client side encrypt
- data is encrypted by the client and never decrypted by the server
- data will be decrypted by a receiving the data
- could leverage Envelope Encryption

## AWS KMS (Key Management Service)
- Anytime you hear encrypt for an AWS Service, its most likely KMS
- Easy way to control access to your data, AWS manages keys for us
- Fully integrated with IAM for authorization
- Seamlessly integrated into:
    - Amazon EBS: encrypt volumes
    - Amazon S3: server side encryption of data
    - Amazon Redshift: encryption of data
    - Amazon RDS: encryption of data
    - Amazon SSM: Parameter store
    - Etc...
- But you can also use the CLI/SDK
- Able to fully manage the keys & policies:
    - Create
    - Rotation policies
    - Disable
    - Enable
- Able to audit key usage (using CloudTrail)
- Three types of Customer Master Key (CMK):
    - AWS Managed Service Default CMK: free    
    - User Keys created in KMS: $1/month
    - User Keys imported (must be 256-bit symmetric key): $1/month
- + pay for API call to KMS ($0.03/10000 calls)
- Anytime you need to share sensitive information... use KMS
    - database passwords
    - credentials to external service
    - private key of SSL certificates
- The value in KMS is that the CMK used to encrypt data can never be retrieved by the user, and the CMK can be rotated for extra security
- Never ever store your secrets in plaintext, especially in your code!
- Encrypted secrets can be stored in the code/environment variables
- KMS can only help in encrypting up to 4KB of data per call
- If data > 4kb, use envelope encryption
- To give access to KMS to someone:
    - make sure the key policy allows the user
    - make sure the IAM Policy allows the API calls

### KMS - Customer Master Key (CMK) Types:
- Symmetric (AES-256 keys)
    - first offering of KMS, single encryption key that is used to Encrypt and Decrypt
    - AWS services that are integrated with KMS use Symmetric CMKs
    - Necessary for envelope encryption
    - You never get access to the Key unencrypted (must call KMS API to use)
- Asymmetric (RSA & ECC key pairs)
    - Public (Encrypt) and Private Key (Decrypt) pair
    - Used for Encrypt/Decrypt, or Sign/Verify operations
    - The public key is downloadable, but you can't access the Primary Key unencrypted
    - Use case: encryption outside of AWS by users who can't call the KMS API

## Copying Snapshots across regions

Region a --> Region b
Region a need create snapshot into s3, transfer to another s3 on another region and restore this snapshot using kms

1. create a snapshot, encrypted with your own CMK
2. attach a KMS key Policy to authorize cross-account access
3. Share the encrypted snapshot
4. (in target) Create a copy of the Snapshot, encrypt it with a KMS Key in your account
5. Create a volume from the snapshot

## envelope file
encrypt up to 4kb
generatedatakey dek
generatedatakeywithoutPlainText
decrypt
generateRandom
## Step Functions
# AWS Step Functions

- build serverless visual workflow to orchestrate your Lambda functions
- Represent flow as a JSON state machine
- Can also integrate with EC2, ECS, On premises server, API Gateway

## Types of Step Functions
Standard: 1 year, over 2k per second
Express: 5 minutes, over 100,000 per second

## X-Ray
Troubleshooting application performance and erros
- bottlenecks
sla
throttled

lambda
gateway
ecs


java
python
go
node 
.net
## Foundation OR landing zone
- Root Account
- Organization Unit (OU)
- Account
- IAM
- Resources

## Service Control Policy (SCP)
- Define policies to apply into accounts or OU
## Well Architected
- Operational Excellence (aws config, amazon inspector, aws cloudformation, aws cloudwatch, )
    - preparar
    - operar
    - evoluir
- Security
- Reliability
- Performance Efficiency
- Cost Optimization
- Sustainability

## Cloudfront (Global Service)
- Content Delivery Network (CDN)
- improves read performances, content is cached at the edge
- improves users expirience
- 216 Point of presence globally (edge locations)

- Origins:
    - S3 bucket (Origin Access Control)
    - Custom Origin (HTTP)

Client --> CloudFront Edge Location --> S3 OR HTTP


### CloudFront vs S3 CRR
CloudFront:
- Global Edge
S3 CRR:
- Must be setup

### CloudFront ALB or EC2 as an origin







## Account Management
- [AWS Status](https://status.aws.amazon.com)
- Personal Health Dashboard
- AWS Organization (Global)
    - Management Account (Master)
    - Member Account
    - not apply to Management account
    - SCP example:
```DenyAccessS3.json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "DenyAccessS3",
      "Effect": "Deny",
      "Action": [
        "s3:*"
      ],
      "Resource": [
        "*"
      ]
    }
  ]
}
```
- Control Tower: Easy way to setup and govern a secure and compliant multi-account aws environment based on best practices
    - runs on top of AWS Organization, Its automatically sets up AWS Organization to organize accounts and implement SCPs (Service Control Policies)

- Service Catalog
    - (Admin)   Product         (CloudFormation Templates)  --> Portfolio (Collection of Products)    --> Control (IAM Permissions to Access Portfolio)
    - (User)    Product List    (Authorized by IAM)         --launch--> Provisioned Products (Ready to use Properly)

    - sharibg options:
        - sync
        - copy    


- AWS Billing Alarms
- Cost Explorer
    - Visualize, understand, and manager your AWS costs and usage over time.
- AWS Budgets
    - Create budget and send alarms when costs exceeds the budget
    - 4 types of budgets:
        1. Usage
        2. Cost
        3. Reservation
        4. Saving Plans

## DataSync
- Move large amount of data to and from
    - on-premises to aws (nfs, smb, hdfs, s3)
    - aws to aws
    - can syncronize to:
        - s3
        - fs
        - fsx


## Amplify
web and mobile applications
a set of tools and services that helps you develop and deploy scalable full stack web and mobile applications
- Backend
    - s3
    - cognito
    - appsync
    - api gateway        
    - sagemaker
    - lex
    - dynamodb
    - lambda
- Console
    - Amplify
    - CloudFront
## IAM Security Tools
- IAM credentials Report (account-level)
- IAM Access Advisor (user-level)

## AWS IAM Identity Center (sucessor to AWS Single Sign-ON)

## AWS Route 53
- A: IP v4
- AAAA: IP v6
- NS: 
- SOA:
- CNAME vs Alias: AWS Resources (ELB, CloudFront) expose an AWS hostname
    - CNAME ONLY Non Root domain
    - Alias works for Root domain and Non Root domain, and free of charge, YOU CANT SET THE TTL
        - ELB
        - CloudFront
        - API Gateway
        - Beanstalk
        - S3 Websites
        - VPC Interface Endpoint
        - Global Accelerator
        - Route 53 Record (same hosted zone)
        * YOU CANNOT SET AN ALIAS RECORD FOR AN EC2 DNS NAME
- Routing Policies:
    - Simple:
        - typically, route traffic to a single resource
        - can specify multiple values in the same record
        - if multiple values are returned, a random value
        - can be associated with health checks
    - Weighted:
        - control the % of the requests that go to each specific resource
        - assign each record a relative Weight
    - Failover
    - Latency based
    - Geolocation
        - specify location by continent, country, or by US State
    - Multi-Value Answer
        - use when routing traffic to multiple resources
        - is not a substitute for having an ELB
    - Geoproximity
        - using route 53 traffic flow feature
        - bias 0|0
        - oeste 1u 2u | 1u 2u leste
        - bias 0|50
        - oeste 1u | 1u 2u 3u leste
        - shift traffic, one region to another







---------------------------------
---------------------------------
---------------------------------

## AWS SA Associate
|Dominio|Descrição|Porcentagem|
|-------|-------|-------|
|1|Design de arquiteturas resilientes|26%|
|2|Design de arquiteturas de alta performance|24%|
|3|Design de arquiteturas seguras|30%|
|4||20%|


### Fortemente acoplado (Tightly coupled)

webserver<---->webapp

### Fracamente acoplado (loosely coupled)

webserver<-->loadbalance<-->webapp

- https://explore.skillbuilder.aws/learn/learning_plan/view/82/cloud-essentials-learning-plan
- https://explore.skillbuilder.aws/learn/learning_plan/view/1044/solutions-architect-learning-plan
- https://explore.skillbuilder.aws/pages/16/learner-dashboard
-