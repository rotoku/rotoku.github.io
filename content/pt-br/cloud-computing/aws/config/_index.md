---
title: "AWS Config"
linkTitle: "AWS Config"
date: 2023-07-25
weight: 11
---

---------------
---------------
---------------

# AWS Config

Audit and compliance configuration
Config Rules
- ebs disk is of type gp2
- each instance is t2.micro
- sg no Compliance

Remediation
-  SSM Automation Documents
Manual
Automatic

Config Aggregator
is one account
rules, resources 
if you using org, no need for individual
rules are created in each source aws account

## Conformance packs
- [Conformance Packs](https://docs.aws.amazon.com/config/latest/developerguide/conformance-packs.html)

## Rules
- [Custom Rules](https://docs.aws.amazon.com/config/latest/developerguide/evaluate-config_develop-rules.html)
- [Examples Custom Rules](https://github.com/awslabs/aws-config-rules)

## Resources

## Authorizations
- [AWS Config Multiple Accounts](https://aws.amazon.com/blogs/aws/aws-config-update-aggregate-compliance-data-across-accounts-regions)

## Aggregated view
- [Using terraform for authorization and aggregator](https://www.terraform.io/docs/providers/aws/r/config_aggregate_authorization.html)

## Pricing
- [AWS Config Pricing](https://aws.amazon.com/config/pricing/)