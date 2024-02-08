# Section#05 - Use Terraform Outside of Core workflow

## Auto Formatting Terraform Code
```
terraform fmt
terraform fmt -recursive
terraform fmt -recursive -check
```
## Replace Resources using Terraform Taint (Rebuild)(15.2 deprecated)
terraform taint is used to mark a Terraform-managed resource as tainted, forcing it to be destroyed and recreated on the next apply.
```
terraform state list
terraform tainted aws_instance.example
terraform apply -auto-approve
terraform plan
terraform untaint aws_instance.example

## alternative for terraform taint
terraform apply -replace="aws_instance.example"
```

## Terraform Import
```
terraform import aws_instance.example i-1234567890abcdef0
```

## Terraform Workspaces - OSS
```
terraform workspace
terraform workspace show
terraform workspace new us-east-1
terraform workspace show
terraform workspace list
terraform show
terraform workspace select default
```

## Terraform State CLI
```
terraform show
terraform state show
terraform state list
terraform state show aws_instance.example

You are managing multiple resources using Terraform running in AWS. You want to destroy all the resources except for a single web server. How can you accomplish this?
terraform state rm aws_instance.example
terraform destroy -auto-approve
```

## Debugging Terraform
```
## linux
export TF_LOG=TRACE

## Powershell
$env:TF_LOG="TRACE"

export TF_LOG_PATH="terraform.log"

## Powershell
$env:TF_LOG_PATH="terraform.log"

terraform init -upgrade

## Turn off
export TF_LOG=''
export TF_LOG_PATH=""
```
