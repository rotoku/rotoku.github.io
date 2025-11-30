provider "aws" {
  region = "sa-east-1"
  default_tags {
    tags = {
      Environment = terraform.workspace
      Owner       = "Kumabe's Org"
      Provisioner = "Terraform"
    }
  }
}