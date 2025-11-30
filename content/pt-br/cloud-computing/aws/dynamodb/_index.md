---
title: "DynamoDB"
linkTitle: "DynamoDB"
date: 2023-07-16
weight: 6
---

---------------
---------------
---------------

# DynamoDB

- NoSQL Serveless Database
- DynamoDB is made of tables
- items == rows
- maximum size of a item is 400kb
- Primary Key
    - Partition key only hash
    - Partition key + Sort key (combination must be unique) [user_id Partition K, game_id Sort K]

Free tier until 10
Read Capacity Unit
Write Capacity Unit
> we write 10 objects per seconds of 2kb each?
> we need 2*10 = 20WCU

> we write 6 objects per seconds of 4,5kb each?
> we need 5*6 = 30WCU

> we write 120 objects per minutes of 2kb each?
> we need 120/60*2 = 4WCU

Strongly Consistent Read: If we read just after a write, we'll get the correct data
Eventually Consistent Read: it's possible we'll get unexpected response because of replication

by default: DynamoDB use Eventually Consistent Read

strong 4
eventually 4*2
Read Capacity Unit 4KB
- 10 strongly reads per seconds of 04Kb each. 10*4kb/4kb = 10RCU
- 16 eventually reads per seconds of 12kb each. (16/2)*(12/4) = 24RCU
- 10 strongly reads per seconds of 06Kb each. 10*8kb/4kb = 20RCU

By Capacity (Total RCU/3000)+(Total WCU/1000)


DynamoDB
- PutItem (create or full replace)
- UpdateItem
- Conditional Writes
- DeleteItem
- DeleteTable
- BatchWriteItem
    - 25 transactions PutItem/DeleteItem
    - 16 MB of data written
    - 400 KB of data per item
- GetItem
    - Read based on PK
- BatchGetItem
    - 100 items
    - 16 MB of data
    - Items are retrieved in parallel to minimize latency
-Query
    - returns items based on PK, SortKey value (=,<,<=,>,>=, Between, Begin)
    - Up to 1MB of data
    - able to do pagination on the results
    - can query table, a local secondary index, or a global secondary index
-Scan
    - the entire table and then filter out data (inefficient)
    - return up to 1 MB of data
    - consume a lot of RCU
    - for faster performance, use parallel scans


## LSI (Local Secondary Index)
- up to 5 local secondary index
- String, Number, Binary

## GSI (Global Secondary Index)
- partition key + optional sort key

## DynamoDB Concurrency
- optimistic locking/concurrency database

## DynamoDB DAX
- Accelerator
- Seamless cache for dynamodb
- solves the hot key problem (too many reads)
- 5 minutes TTL for cache by default
- up to 10 nodes in the cluster
- multi az (3 nodes minimum recommended for production)
- secure (encrypt at the rest)

## DynamoDB Streams
- changes in dynamodb can end up in a dynamodb stream
- this stream can be read by aws lambda (event source mapping) & ec2 instances
- informations:
    - keys_only: only key
    - new_image: entire new item
    - old_image: entire old item
    - new_and_old_images:: entire new and old item

dynamodb stream --> (lambda trigger) --> lambda

## DynamoDB TTL (Time To Live)
- automatically delete an item after an expiry date/time

## DynamoDB CLI
- "--projection-expression"
- "--filter-expression"
- General CLI pagination options including DynamoDB/S3
    - Optimization
        - 
    - Pagination:
        - "--max-items"
        - "starting-token"

```
aws dynamodb create-table \
    --table-name customers \
    --attribute-definitions \
        AttributeName=id,AttributeType=S \
        AttributeName=name,AttributeType=S \
    --key-schema \
        AttributeName=id,KeyType=HASH \
        AttributeName=name,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --region us-east-1

aws dynamodb create-table \
    --table-name customers-sa-east-1 \
    --attribute-definitions \
        AttributeName=id,AttributeType=S \
        AttributeName=name,AttributeType=S \
    --key-schema \
        AttributeName=id,KeyType=HASH \
        AttributeName=name,KeyType=RANGE \
    --provisioned-throughput \
        ReadCapacityUnits=1,WriteCapacityUnits=1 \
    --region sa-east-1    

aws dynamodb list-tables --region us-east-1
aws dynamodb list-tables --region sa-east-1


aws dynamodb put-item \
    --table-name customers \
    --item '{
        "id": {"S": "a9dbdc75-d8cd-4353-8549-3d26548fe318"},
        "name": {"S": "Rodrigo"} ,
        "gender": {"S": "Male"} 
      }' \
    --return-consumed-capacity TOTAL

aws dynamodb put-item \
    --table-name customers \
    --item '{ 
        "id": {"S": "702ec710-b168-489a-95fd-90972629508c"}, 
        "name": {"S": "Michele"} , 
        "gender": {"S": "Female"} 
      }' \
    --return-consumed-capacity TOTAL

aws dynamodb scan \
    --table-name customers \
    --region us-east-1 \
    --max-items 5

aws dynamodb scan \
    --table-name customers \
    --region sa-east-1 \
    --max-items 5 \
    --starting-token eyJFeGNsdXNpdmVTdGFydEtleSI6IG51bGwsICJib3RvX3RydW5jYXRlX2Ftb3VudCI6IDV9


aws dynamodb scan \
    --table-name customers \
    --region sa-east-1 \
    --max-items 5 \
    --starting-token eyJFeGNsdXNpdmVTdGFydEtleSI6IG51bGwsICJib3RvX3RydW5jYXRlX2Ftb3VudCI6IDEwfQ==


aws dynamodb scan \
    --table-name customers \
    --region sa-east-1 \
    --max-items 5 \
    --starting-token eyJFeGNsdXNpdmVTdGFydEtleSI6IG51bGwsICJib3RvX3RydW5jYXRlX2Ftb3VudCI6IDE1fQ==

aws dynamodb scan \
    --table-name customers \
    --region sa-east-1
```

## DynamoDB Transactions
- its similar to RDBMS transaction, all or nothing
- consume 2 RCU AND WCU

## DynamoDB Session State
- its common to use dynamodb to store session state
- DynamoDB is serveless

## DynamoDB Partitioning Strategies

## DynamoDB Conditional Writes, Concurrent Writes, Atomic Writes & Batch Writes

## DynamoDB Patterns with S3
- 400KB
- large object upload to s3, write small metadata
- index: s3 --> lambda --> dynamodb
## DynamoDB Operations
- table cleanup
    - scan + delete => very slow
    - drop table and recreate
- copying
    - use AWS DataPipeline (uses EMR)
    - create backup and restore them
    - Scan table and Write on new table
## DynamoDB Security & Other
- vpc endpoints
- iam role
- rest use kms
- transit use SSL/TLS
- backup and restore feat. available
- amazon dms can be used to migrate
- you can use dynamodb in your local pc



## Export all items from the source table to a JSON file:
```bash
aws dynamodb scan \
  --table-name <source-table> \
  --region <region> \
  --output json > backup.json
```

## Prepare Data for Import
```bash
jq '{ "customers": [ .Items[] | { PutRequest: { Item: . } } ] }' backup.json > batch.json
```

## Import the data into the new table:
```bash
aws dynamodb batch-write-item \
  --request-items file://batch.json \
  --region <region>
```

## Delete table
```bash
aws dynamodb delete-table --table-name customers --region us-east-1
aws dynamodb delete-table --table-name customers-sa-east-1 --region sa-east-1
```