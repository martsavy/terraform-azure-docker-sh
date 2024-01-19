locals {
  registry_prefix = replace("${var.prefix}", "-", "")
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "example" {
  name     = "${var.prefix}-resources"
  location = var.location
}

# Create the Container Registry
resource "azurerm_container_registry" "example" {
  name                = "${local.registry_prefix}registry"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  sku                 = "Standard"
  admin_enabled       = true
  depends_on = [
    azurerm_resource_group.example
  ]
}

