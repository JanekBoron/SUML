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


variable "subscription_id" {
  type        = string
  description = "Azure Subscription ID"
}

variable "client_id" {
  type        = string
  description = "Azure Client ID"
}

variable "client_secret" {
  type        = string
  description = "Azure Client Secret"
  sensitive   = true
}