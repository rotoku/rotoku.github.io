---
title: "Lambda"
linkTitle: "Lambda"
date: 2023-07-16
weight: 9
---

---------------
---------------
---------------

# Lambda

Function as a Service

Servless: no servers to manage!

free tier 1000000 lambda request and 4000,000 GBs of compute time

Languages:
- node
- python
- java
- c#
- golang
- ruby
- custom runtime
- lambda container image

Integrations:
- API Gateway
- Kinesis
- DynamoDB
- S3
- CloudFront
- CloudWatch Events Event Bridge
- CloudWatch Logs
- SNS
- SQS
- Cognito


Example: Servless Thumbnail creation
S3 --> trigger lambda --> push to S3 or DynamoDB

Example: Servless CRON Job
CloudWatch Event --> trigger Lambda to perform a task


Assync
- S3
    * SNS --> SQS
    * SQS --> Lambda
    * Lambda --> SQS
- SNS
- CloudWatch Events/Event Bridge
    * cron task trigger lambda
- CodeCommit
- CodePipeline
- CloudWatch Logs (log processing)
- Simple Email Service
- CloudFormation
- Config
- IoT
- IoT Events


Event Source Mapping
    - Kinesis
    - Streams & Lambda (Kinesis & DynamoDB)
    - SQS & SQS FIFO (Long Polling)
    - Queues & Lambda
Event Source Mapping Scaling
    - Kinesis Data Stream & DynamoDB Streams
    - SQS
    - SQS FIFO


## Lambda - Destinations (use this instead DLQ)
- SQS
- SNS
- Lambda
- EventBridge bus

Event Source Mapping Discard 
- SQS
- SNS


(out VPC)Lambda --> Elastic Network Interface --> RDS
Lambda --> NAT --> IGW --> External API
(in VPC)Lambda --> VPC Endpoint --> DynamoDB
(in VPC)Lambda --> NAT --> IGW --> DynamoDB

## Basic settings
- memory
- timeout
- execution role

Lambda Function COnfiguration
RAM:
    - from 128mb to 10GB in 1mb increments
    - if you need increase performance, increase memory

Timeout: default 3sec, maximum is 900s (15 minutes)    

Lambda Context: is temporary runtime you use to load external resources

Initialize outside the handler
```
import os

DB_URL = os.getenv("DB_URL")
db_client = db.connect(DB_URL)

def get_user_handler(event, context):
    user = db_client.get(user_id = event["user_id"])

    return user
```

## Lambda Functions /tmp space
- if your lambda function needs to download a big file to work
- max size is 10GB
- non temporary files use s3

## Lambda Concurrency and Throttling
- Concurrency limit: up to 1000 current executions
- if you need more than limit, you can open ticket
- s3 bucket --> lambda
- throttling errors 429 and system errors 500-series
- 6 hours trying
- cold start: code is loaded and code outside the handler run
- provisioned concurrency: is allocated before the function is invoked
- reserved and provisioned concurrency

## Lambda external dependencies
- aws x-ray sdk, database clients, etc
- you need install the packages alongside your code and zip it together

## Lambda and CloudFormation
- inline

## Lambda Layers
- Custom Runtimes
    - C++
    - Rust
- create layers for dependencies

## AWS Lambda Versions
- Qualifiers
    - version immutable
    - alias mutable (can apply blue/green strategy)

## Lambda & CodeDeploy
- CodeDeploy can help you automate traffic shift for lambda aliases
- Linear
- Canary
- AllAtOnce: Immediate

## AWS Lambda Limits to Know - per region
- execution:
    - memory allocation: 128mb - 10GB (1mb increments)
    - maximum execution time: 900 seconds (15 minutes)
    - env variable 4 kb
    - disk capacity /tmp 10GB