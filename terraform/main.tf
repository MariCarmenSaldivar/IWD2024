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

provider "azurerm" {
  features {}
}

provider "google" {
  project     = "iwd-2024-419319"
  region      = "us-central1"
  zone        = "us-central1-c"
}


resource "google_compute_network" "vpc_network" {
  name                    = "my-custom-mode-network"
  auto_create_subnetworks = false
  mtu                     = 1460
}

resource "google_compute_subnetwork" "default" {
  name          = "my-custom-subnet"
  ip_cidr_range = "10.0.1.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}


resource "azurerm_resource_group" "rg" {
  location = "eastus2"
  name     = "iwd2024"
}

# resource "azurerm_static_web_app" "example" {
#   name                = "iwdstwebapp"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = azurerm_resource_group.rg.location
# }