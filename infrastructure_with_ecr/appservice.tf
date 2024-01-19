resource "azurerm_service_plan" "example" {
  name                = "${var.prefix}-sp-zipdeploy"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_web_app" "example" {
  name                = "${var.prefix}-example"
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  service_plan_id     = azurerm_service_plan.example.id

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                               = true
    container_registry_use_managed_identity = true
    application_stack {
      docker_image_name   = var.image
      docker_registry_url = "https://${azurerm_container_registry.example.login_server}"
    }
  }
}

data "azurerm_subscription" "current" {}

data "azurerm_role_definition" "acr_pull" {
  name = "AcrPull"
}

resource "azurerm_role_assignment" "pull_image" {
  role_definition_id = "${data.azurerm_subscription.current.id}${data.azurerm_role_definition.acr_pull.id}"
  scope              = azurerm_container_registry.example.id
  principal_id       = azurerm_linux_web_app.example.identity.0.principal_id
}