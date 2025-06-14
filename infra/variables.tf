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
