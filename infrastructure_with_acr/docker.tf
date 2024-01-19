terraform {
  required_providers {
    docker = {
      source  = "kreuzwerker/docker"
      version = "3.0.2"
    }
  }
}

provider "docker" {
  registry_auth {
    address  = azurerm_container_registry.example.login_server
    username = azurerm_container_registry.example.admin_username
    password = azurerm_container_registry.example.admin_password
  }
}

resource "docker_registry_image" "example" {
  name          = docker_image.image.name
  keep_remotely = false
}

resource "docker_image" "image" {
  name = "${azurerm_container_registry.example.login_server}/${var.image}"
  build {
    context = "${path.cwd}/../application"
  }
}