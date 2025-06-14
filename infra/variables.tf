variable "location" {
  description = "Azure region"
  default     = "westeurope"
}

variable "prefix" {
  description = "Prefiks do nazw zasobów"
  type        = string
}

variable "container_registry" {
  description = "np. 'boronekziomek' dla DockerHub lub '<myacr>.azurecr.io' dla ACR"
  type        = string
}

variable "image_name" {
  description = "Nazwa obrazu (bez rejestru i taga), np. 'asystent-snu'"
  type        = string
}

variable "docker_image_tag" {
  description = "Tag obrazu, np. 'latest'"
  type        = string
  default     = "latest"
}

variable "subscription_id" {
  description = "Azure Subscription ID"
  type        = string
}

variable "client_id" {
  description = "Azure Client ID"
  type        = string
}

variable "client_secret" {
  description = "Azure Client Secret"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "Azure Tenant ID"
  type        = string
}

# Jeżeli chcesz uwierzytelniać się do prywatnego rejestru DockerHub/ACR:
#variable "registry_url" {
#  description = "URL prywatnego rejestru, np. 'https://index.docker.io' lub 'https://<myacr>.azurecr.io'"
#  type        = string
#  default     = "https://index.docker.io"
#}

variable "registry_username" {
  description = "Użytkownik rejestru Docker"
  type        = string
}

variable "registry_password" {
  description = "Hasło do rejestru Docker"
  type        = string
  sensitive   = true
}
