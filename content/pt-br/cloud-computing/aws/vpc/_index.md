---
title: "VPC"
linkTitle: "VPC"
date: 2023-10-27
weight: 13
---

---------------
---------------
---------------

# VPC

- CIDR: IP Range
- VPC: Virtual Private Cloud => we define a list of IPv4 & IPv6 CIDR
- Subnets: tied to an AZ, we define CIDR
- Internet Gateway: at the VPC level, provide IPv4 & IPv6 Internet Access
- Route Tables: must be edited to add routes from Subnets to the IGW, VPC Peering connections, VPC Endpoints...
- NAT Instance: gives internet access to ec2 instances in private subnets. Old, must be setup in a public subnet, disable Source/Destination check flag
- NAT Gateway: managed by AWS, provides scalable Internet access to private EC2 instances, IPv4 only
- Private DNS + Route 53: enable DNS resolution + DNS hostnames (VPC)
- statefull vs stateless: 
    - statefull allows the return traffic automatically
    - stateless: checks for an allow rule for both connections
- NACL: Firewall for subnet level and stateless    
- SG: statefull, operate at the EC2 instance level
- Reachability Analyzer: perform Network Connectivity testing between AWS resources
- VPC Peering: connect two VPCs with non overlapping CIDR, non-transitive
- VPC Endpoint: provide private access to AWS services (s3, dynamodb, CloudFormation, SSM) within a VPC
    - Interface Endpoints: support almost aws services, best way to access is required from on-premises
    - Gateway Endpoints: free, s3 and dynamodb
- VPC Flow Logs: can be setup at the vpc/subnet/eni level, for accept and reject traffic, helps Identify attacks, analyze using Athena or cloudwatch logs Insights

Site to Site (Public Internet)
Customer Gateway
Virtual Private Gateway
Site-to-Site

Site to N Site (Public Internet)
Customer Gateway
Virtual Private Gateway
AWS VPN CloudHub
Site-to-Site

DX
Customer Gateway
Direct Connect (Dedicated or Pattern)[1 month to stabilish]
Virtual Private Gateway


AWS Private Link (VPC Endpoint Services)
app service --> nlb --> aws private --> eni --> consume app 
                |------AWS Private Link-------|

Transit Gateway
alternative to Peering gateway
resource can work cross region
IP multicast
ECMP = Equal Cost multi-path
2.5 gbps - 2 tunels

VPCa,VPCb <--> Transit Gateway <--> Direct Conect Gateway <--> AWS Direct Connect endpoint <--> Customer Router
|------------------------AWS----------------------------|     |--------------DX------------|    |-On-premises-|

VPC traffic Mirroring
allow to capture traffic, from eni to eni/nlb

IP v6 for VPC

Egress-only Internet Gateway (IPv6) is used to acess internet from private subnet

VPC Firewall