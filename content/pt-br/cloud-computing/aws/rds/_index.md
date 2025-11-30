---
title: "RDS"
linkTitle: "RDS"
date: 2023-10-27
weight: 14
---

---------------
---------------
---------------

# RDS
Relational Database Service

Kinds of Database:
- MariaDB
- MySQL
- PostgreSQL
- SQL Server
- Oracle
- Aurora

### Single AZ
### Multi AZ
### Cross Region
### Read Replica
### RDS Proxy
### Parameter Groups
> When we modify or create another one we need reboot the db instance
Must-know parameter:
- PostgreSQL / SQL Server: rds.force_ssl=1 => force SSL connections
- Reminder: for SSL on MySQL / MariaDB, you must run:
```
GRANT SELECT ON mydatabase.* TO 'myuser'@'%' IDENTIFIED BY '...' REQUIRE SSL;
```

### RDS Backup vs Snapshot
#### Backup
- When we enable multi az is possible to improve the performance
- area continuous
- retention period you set between 0 and 35 days
- backup happen during maintenance windows
#### Snapshot
- takes IO operations and can stop the database from seconds to minutes
- Multi AZ DB don't impact the master - just the standby
- you can copy and share Snapshots

### RDS Events & Event Subscriptions


### RDS Storage Auto Scaling
> You can only scale up your RDS storage once within 6 hours

### Aurora
- 5x better than MySQL
- 3x better than PostGresql
- Auto Spanding Storage 10GB to 128 TB
- 20% more sheper
- 6 copies of your data across az
- 1 Master writter endpoint
- 5 slave reader endpoint (VIP)
- cross region replication
- Automatic Patching Zero Downtime
- Backup
- Backtrack
- Clone

### SysOps
- You can associente 1 to 15 read replicas for Single Aurora Cluster
- migrate to aurora from snapshot mysql
- Metrics:
    - AuroraReplicaLag
    - AuroraReplicaLagMaximum
    - AuroraReplicaLagMaximum
    - Connection
    - Latency


## Elastic Cache
Uses Cases:
- DB Cache
- User Session Store


- MemCached (non-persistence, multi-node, multi thread)
- Redis (persistence, multi az, read replicas, backup and restore)

### Cluster Mode Disable
Horizontal:
One primery node,up to 5 replicas
Vertical:
    Size of cluster, t2, r4 and etc;;;
### Cluster Mode Enable
Data is partitioned across shards
each shard has a primary and up to 5 replica nodes
multi az capability
up to 500 nodes per cluster
    - 500 shards with single master
    - 250 shards with 1 master and 1 replica

### SysOps
#### Cluster Mode Disable
- Horizontal
- Vertical

#### Cluster Mode Enable
- Two Modes:
    - Online
    - Offline
- Horizontal (Resharding)
- Vertical (Change Instance Type)

Metrics:
- Evictions (infos que ainda estão no cache que não expiraram)
- CPUUtilization
- SwapUsage: should not exceed 50 MB
- CurrConnections
- DatabaseMemoryUsagePercentage
- NetworkBytesIn/Out & NetworkPackatsIn/Out
- ReplicaBytes
- ReplicaLag


### MemCache SysOps
- 1-40 nodes softlimit
- Horizontal
- Vertical

Metrics:
- FreeableMemory
- Evictions (infos que ainda estão no cache que não expiraram)
- CPUUtilization
- SwapUsage: should not exceed 50 MB
- CurrConnections