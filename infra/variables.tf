variable "location" {
  default = "westeurope"
}

variable "prefix" {
  description = "Prefiks do nazewnictwa zasobów"
}

variable "container_registry" {
  description = "docker.io/boronekziomek"
}

variable "image_name" {
  default = "asystent-snu"
}

variable "docker_image" {
  description = "Docker image for the Linux Web App"
  type        = string
  default     = "boronekziomek/asystent-snu:latest"  
}


variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

variable "client_id" {
  description = "Azure Client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}