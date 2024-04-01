    # The configuration for the `remote` backend.
    terraform {
      backend "remote" {
        # The name of your Terraform Cloud organization.
        organization = "saldivar"

        # The name of the Terraform Cloud workspace to store Terraform state files in.
        workspaces {
          name = "iwd-test-us-east"
        }
      }
      required_providers {
      azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.7.0"
    }
  }
  }

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = "eastus"
  name     = "iwd2024"
}


resource "azurerm_static_site" "example" {
  name                = "iwdstsite"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}