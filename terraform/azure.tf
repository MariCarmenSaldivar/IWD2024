provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  location = "eastus2"
  name     = "iwd2024"
}

# Generate a random integer to create a globally unique name
resource "random_integer" "ri" {
  min = 10000
  max = 99999
}
