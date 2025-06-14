terraform {
  required_version = ">= 1.1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "suml-rg"
  location = "East US"
}

resource "azurerm_app_service_plan" "plan" {
  name                = "suml-appserviceplan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "B1"
  kind                = "Linux"
  reserved            = true
}

resource "azurerm_web_app" "app" {
  name                = "suml-webapp"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  app_service_plan_id = azurerm_app_service_plan.plan.id

  site_config {
    linux_fx_version = "DOCKER|${var.docker_image}"
  }

  app_settings = {
    "WEBSITES_ENABLE_APP_SERVICE_STORAGE" = "false"
  }
}

variable "docker_image" {
  type    = string
  default = "yourdockeruser/asystent-snu:latest"
}
