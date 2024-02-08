# Configure the AWS Provider
provider "aws" {
  region = "sa-east-1"
}

terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.31.0"
    }
  }

  backend "s3" {
    bucket  = "008736932128-statefile"
    key     = "sa-east-1"
    region  = "sa-east-1"
    encrypt = true
  }

}