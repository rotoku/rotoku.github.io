---
title: "Cloud Formation"
linkTitle: "Cloud Formation"
date: 2017-01-05T00:00:00.000Z
weight: 2
---

---------------
---------------
---------------

# [CloudFormation](https://docs.aws.amazon.com/AWSCloudFormation/latest/APIReference/Welcome.html)
O AWS CloudFormation é um serviço fornecido pela Amazon Web Services que permite aos usuários modelar e gerenciar recursos de infraestrutura de maneira automatizada e segura.

## Kinds of files:
- JSON
- YAML

## Components:
- Parameters
- Resources
- Outputs

## Resources

## Parameters

```
Parameters:
  

## Reference Resources
DBSubnet1:
  Type: AWS::EC2::Subnet
  Properties:
    VpcId: !Ref MyVPC
```    


## Mappings

>when you know in advance all the values that can be taken and that they can be deduced.

```
RegionMap:
  us-east-1:
    "32": "ami-6411e20d"
    "64": "ami-6411e213"
  us-west-1:
    "32": "ami-c9c1e20d"
    "64": "ami-cfc1e213"


      ImageId: !Fn::FindInMap [RegionMap, !Ref "AWS::Region", 32]
```

## Outputs
>we can import into other stack, It's the best way to perform some collaboration
```
Outputs:
  StackSSHSecurityGroup:
    Description: Teste
    Value: Teste
    Export:
      Name: SSHSecurityGroup


Resources:
  MySecurityGroup:
    ...
      ...
        SecurityGroups:
          - !ImportValue SSHSecurityGroup   
```

## Conditions
```
Conditions:
  CreateProdResources: !Equals [ !Ref EnvType, prod ]

Resources:
  MountPoint:
    Type: "AWS::EC2::VolumeAttachment"  
    Condition: CreateProdResources
```

### The intrinsic function
- Fn::And
- Fn::Equals
- Fn::If
- Fn::Not
- Fn::Or

## CloudFormation Must Know intrinsic function
- !Ref
    - Parameters
    - Resources
- Fn:GetAtt
    - Resources
    - !GetAtt EC2Instance.AvailabilityZone
- Fn::FindInMap
- Fn::ImportValue
- Fn:Join
    - !Join [ ":", [a, b, c] ]
- Fn:Sub
  - Json: { "Fn::Sub": "arn:aws:ec2:${AWS::Region}:${AWS::AccountId}:vpc/${vpc}" }
  - YAML: !Sub 'arn:aws:ec2:${AWS::Region}:${AWS::AccountId}:vpc/${vpc}'
- Condition Functions (Fn::And, Fn::Equals, Fn::If, Fn::Not, Fn::Or)


StackSets: Multiple Accounts and Regions
