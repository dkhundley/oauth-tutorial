# Setting the overarching Terraform block
terraform {
  required_providers {
    azuread = {
      source  = "hashicorp/azuread"
      version = "~> 2.0"
    }
  }
}

# Setting the Azure AD (Entra ID) provider
provider "azuread" {}

# Getting current information about the Azure account
data "azuread_client_config" "current" {}