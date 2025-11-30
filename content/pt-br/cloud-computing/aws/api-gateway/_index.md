---
title: "API Gateway"
linkTitle: "API Gateway"
date: 2017-01-05T00:00:00.000Z
weight: 1
---

---------------
---------------
---------------

# API Gateway

> Client --> API Gateway --> Lambda --> DynamoDB

- handle api versioning
- handle different envs
- handle security
- generate SDK and API Specification

## Endpoint Types
- Edge-Optimized (default) within cloudfront edge location
- Regional, for clients within same region
- private, can only be accessed in your vpc

## Stage Variables
- use to separate the stages and change it dynamic

## Canary Deployment
- possibility to enable canary deployments for any stage
- choose the % of traffic the canary channel receives

deploy prod canary
:1 (prod)
:2 (test)

## Integration Types
- Mock
- HTTP/AWS (Lambda & AWS Services)
- AWS Proxy
- HTTP Proxy
- Mapping Templates
    - modify request, response, parameters, body, headers
    - example: json to xml with soap

## Caching API responses
- Default TTL 300 seconds, min 0, max 3600
- its not free tier
- invalidate: header: Cache-Control:age=0


## Usage Plans & API Keys
- Usage Plans
    - who can access one or more deployed API stages and methods
    - how much and how fast they can access them

## Monitoring, Logging and Tracing
- CloudWatch Logs
- X-Ray
- CloudWatch Metrics
    - CacheHitCount & CacheMissCount
    - Count
    - IntegrationLatency
    - Latency
    - 4XXError (client-side) and 5XXError (server-side)
- Throttling
    - Account Limit
    - in case of Throttling => 429 Too Many Request
- Errors
    - 4xx means client erros
        - 400 bad request
        - 403 access denied, waf filtered
    - 5xx means server errors

## CORS
- must be enabled when you receive API calls from another domain.
- The OPTIONS pre-flight request must contain the following headers:
    - Access-Control-Allow-Methods
    - Access-Control-Allow-Headers
    - Access-Control-Allow-Origin

## Authentication and Authorization
- create an IAM policy authorization and attach to User/Role

- authentication = IAM | Authorization = IAM Policy
    - leverages signature v4
    - Resource policies
    - allow for cross account access

- cognito user pools (db of users)
    - auth = Cognito User Pools | authorization = API Method Methods

- Lambda Authorizer (custom authorizer)
    - Token-based authorizer (bearer token), JWT or OAuth
    - Auth = External | Authoriza = Lambda function

## HTTP API vs REST API
- HTTP API low-latency, cost-effective AWS Lambda proxy, support OIDC and OAuth 2.0 authorization, and built-in support for CORS, No usage plans and API Keys.
- REST API all features (except Native OpenID Connect/OAuth 2.0)

## AppSync
- real-time update using web-socket
- GraphQL
- syncronized mobile app
- get just what you need
- Security: API_KEY, AWS_IAM, OPEN_ID, AMAZON_COGNITO_USER_POOL