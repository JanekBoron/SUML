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