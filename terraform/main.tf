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
      version = "=3.97.1"
    }
  }
}

provider "google" {
  project = "iwd-2024-419319"
  region  = "us-central1"
  zone    = "us-central1-c"
}