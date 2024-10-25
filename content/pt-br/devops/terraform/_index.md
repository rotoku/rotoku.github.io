---
title: "Terraform"
linkTitle: "Terraform"
date: 2023-07-16
weight: 4
---

---------------
---------------
---------------

# Terraform
```
echo "fmt"
terraform fmt -recursive -check
      
echo "init"
terraform init

echo "validate"
terraform validate -no-color

echo "plan"
terraform plan -var-file="variables/prod/terraform.tfvars" -no-color -input=false

echo "apply"
terraform apply -var-file="variables/prod/terraform.tfvars" -auto-approve -input=false

echo "destroy"
terraform destroy -var-file="variables/prod/terraform.tfvars" -no-color -auto-approve -input=false
```

## Links
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2002%20-%20Understand%20IAC%20Concepts/02%20-%20Benefits_of_Infrastructure_as_Code.md
- https://developer.hashicorp.com/terraform/intro/use-cases#multi-cloud-deployment
- https://docs.aws.amazon.com/pt_br/cli/latest/userguide/cli-configure-envvars.html
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2002%20-%20Understand%20IAC%20Concepts/01%20-%20What_is_Infrastructure_as_Code.md
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started/infrastructure-as-code
- https://www.hashicorp.com/blog/infrastructure-as-code-in-a-private-or-public-cloud
- https://www.pulumi.com/
- https://cloud.google.com/deployment-manager/docs
- https://learn.microsoft.com/en-us/azure/azure-resource-manager/management/overview
- https://aws.amazon.com/cloudformation/
- https://www.terraform.io/
- https://github.com/btkrausen/hashicorp/tree/master/terraform
- https://github.com/btkrausen/hashicorp/tree/master/terraform/Hands-On%20Labs
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2003%20-%20Understand%20The%20Purpose%20of%20Terraform/02%20-%20Benefits_of_State.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2003%20-%20Understand%20The%20Purpose%20of%20Terraform/02%20-%20Benefits_of_State.md
- https://www.hashicorp.com/products/terraform
- https://developer.hashicorp.com/terraform/language/state/remote
- https://developer.hashicorp.com/terraform/language/state
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2003%20-%20Understand%20The%20Purpose%20of%20Terraform/01%20-%20Terraform_Purpose.md
- https://github.com/conradludgate/terraform-provider-spotify
- https://github.com/nat-henderson/terraform-provider-dominos
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/01%20-%20Terraform_Basics.md
- https://github.com/btkrausen/hashicorp/tree/master/terraform/Lab%20Prerequisites/Section%2004%20-%20Understand%20Terraform%20Basics/Terraform%20Basics
- https://developer.hashicorp.com/terraform/tutorials/aws-get-started
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/02%20-%20HashiCorp_Configuration_Language.md
- https://developer.hashicorp.com/terraform/language/syntax/configuration
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/03%20-%20Terraform_Plugin_Based_Architecture.md
- https://developer.hashicorp.com/terraform/plugin/how-terraform-works
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/04%20-%20Intro_to_the_Terraform_Provider_Block.md
- https://developer.hashicorp.com/terraform/language/providers
- https://developer.hashicorp.com/terraform/language/resources
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/05%20-%20Intro_to_the_Terraform_Resource_Block.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/06%20-%20Intro_to_the_Input_Variables_Block.md
- https://developer.hashicorp.com/terraform/language/values/variables
- https://developer.hashicorp.com/terraform/language/values/locals
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/07%20-%20Intro_to_the_Local_Variables_Block.md
- https://developer.hashicorp.com/terraform/language/data-sources
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/08%20-%20Intro_to_the_Terraform_Data_Block.md
- https://developer.hashicorp.com/terraform/language/settings
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/09%20-%20Intro_to_the_Terraform_Configuration_Block.md
- https://developer.hashicorp.com/terraform/language/modules/syntax
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/10%20-%20Intro_to_the_Module_Block.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/11%20-%20Intro_to_the_Terraform_Output_Block.md
- https://developer.hashicorp.com/terraform/language/values/outputs
- https://developer.hashicorp.com/terraform/language/syntax/configuration#comments
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/12%20-%20Commenting_Terraform_Code.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/13%20-%20Terraform_Providers_Installation.md
- https://developer.hashicorp.com/terraform/language/expressions/version-constraints
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/14%20-%20Multiple_Terraform_Providers.md
- https://registry.terraform.io/providers/hashicorp/tls/latest/docs
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/15%20-%20Terraform_TLS_Provider.md
- https://developer.hashicorp.com/terraform/language/providers/configuration
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/16%20-%20Fetch_Version_and_Upgrade_Terraform_Providers.md
- https://developer.hashicorp.com/terraform/language/resources/provisioners/syntax
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2004%20-%20Understand%20Terraform%20Basics/17%20-%20Terraform_Provisioners.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2005%20-%20Use%20Terraform%20outside%20of%20core%20workflow/01%20-%20Auto_Formatting_Terraform_Code.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2005%20-%20Use%20Terraform%20outside%20of%20core%20workflow/02%20-%20Terraform_Taint_and_Replace.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2005%20-%20Use%20Terraform%20outside%20of%20core%20workflow/03%20-%20Terraform_Import.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2005%20-%20Use%20Terraform%20outside%20of%20core%20workflow/04%20-%20Terraform_Workspaces_OSS.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2005%20-%20Use%20Terraform%20outside%20of%20core%20workflow/05%20-%20Terraform_State_CLI.md
- https://github.com/btkrausen/hashicorp/blob/master/terraform/Hands-On%20Labs/Section%2005%20-%20Use%20Terraform%20outside%20of%20core%20workflow/06%20-%20Debugging_Terraform.md
- 
- 
- 
- 
- 
- 