variable "location" {
  default = "westeurope"
}

variable "prefix" {
  description = "Prefiks do nazewnictwa zasobów"
}

variable "container_registry" {
  description = "Adres registry, np. docker.io/TwojUser"
}

variable "image_name" {
  default = "suml-app"
}
