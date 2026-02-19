# Setting the overarching Terraform block
terraform {
  required_version = ">= 1.6.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }
}

# Setting the AWS provider
provider "aws" {
  region = var.aws_region
}