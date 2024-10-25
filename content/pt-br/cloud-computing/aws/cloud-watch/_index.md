---
title: "Cloud Watch"
linkTitle: "Cloud Watch"
date: 2017-01-05T00:00:00.000Z
weight: 4
---

---------------
---------------
---------------

# CloudWatch

is used fir oerfirnabce monitoring, alarms, log collection and automation.

- metrics for every services in aws
    - CPU Utilization
    - Network In
    - Metrics belong to namespace
        - ApiGateway
        - CloudFront
        - CloudHSM
        - Logs
        - CodeBuild
        - Cognito
        - DynamoDB
        - EC2
        - ElasticBeanstalk
    - EC2 have metrics every 5 minutes
        - with detailed you have costs 1 minutes
    - possibility to define custom metrics
    - metric resolution, high resolution up to 1 seconds higher cost
    - use exponentials backoff
    - custom
        - disk Utilization
        - mem Utilization
- logs
    - export to s3
    - elastic beanstalk
    - ecs    
    - kinesis
    - aws lambda
    - vpc flow logs
    - api gatewat
    - cloudtrail
    - cloudwatch log agents
        - by default no logs from your ec2 send to cloudwatch
        - you need to run cloudwatch agent
        - Is possible to run the agents into on-premises machines
        - logs agent
            - old version
            only cloudwatch
        - logs unified agent
            - collect on your linux server/ec2 instance
            - cpu
            - disk metrics
            - RAM
            - netstat
            - processes
            - swap space
    - route53
    logs can goto
    - batch exporter to s3 for archival
    - stream to elasticsearch
- events
- alarms
    - used to trigger notifications for any metric
    - can go to Auto Scaling, EC2 Actions, SNS notifications
    - various samplings %,max, min
    - from alarm you can attach policy to increase and decrease ec2

state value:
- OK
- ALARM
- INSUFFICIENT_DATA
aws cloudwatch set-alarm-state --alarm-name "myalarm" --state-value ALARM --state-reason "testing purposes"

## API Actions (Metrics)
- GetMetricData
    - Retrieve as many as 500 different metrics in a sigle request
- PutMetricData
    - Publishes metric data points to Amazon CloudWatch
    - CloudWatch associates the data points with the specified metric
    - If the specified metric does not exist, CloudWatch creates the metric
- GetMetricStatistics
    - Gets statistics for the specified metric
    - CloudWatch aggregates data points based on the length of the period that you specify
    - Maximum number of data points returned from a single call is 1,440

### CloudWatch Events (deprecated) --> Event Bridge
### Event Bridge
Default Event Bus
Partner Event Bus (third-party SaaS apps)
- ZenDesk
- DataDog
- Segment
- Auth0
Schema Registry
Resource Based Policy