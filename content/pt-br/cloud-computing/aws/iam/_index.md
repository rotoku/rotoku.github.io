---
title: "IAM"
linkTitle: "IAM"
date: 2023-07-16
weight: 14
---

---------------
---------------
---------------

# IAM

## Role
- DevSecOpsStackSetRole
    - Policy: PowerUserAccess
```Trust
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Principal": {
                "AWS": "arn:aws:iam::423252994863:root"
            },
            "Action": "sts:AssumeRole",
            "Condition": {}
        }
    ]
}
```