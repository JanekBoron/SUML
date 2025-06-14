terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.40.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "rg" {
  name     = "${var.prefix}-rg"
  location = var.location
}

resource "azurerm_app_service_plan" "plan" {
  name                = "${var.prefix}-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  kind                = "Linux"

  sku {
    tier = "Basic"
    size = "B1"
  }

  reserved = true
}

resource "azurerm_linux_web_app" "app" {
  name                = "${var.prefix}-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_app_service_plan.plan.id
  https_only          = true

  site_config {
    always_on = true

    application_stack {
      # image name bez taga
      docker_image_name = "${var.container_registry}/${var.image_name}"
      # tylko tag
      docker_image_tag  = var.docker_image_tag

      # poniższe odkomentuj, jeśli używasz prywatnego DockerHub lub ACR
      # docker_registry_url      = var.registry_url
      # docker_registry_username = var.registry_username
      # docker_registry_password = var.registry_password
    }
  }

  app_settings = {
    WEBSITES_ENABLE_APP_SERVICE_STORAGE = "false"
  }
}
