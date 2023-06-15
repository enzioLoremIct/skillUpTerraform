variable "stage" {
  type    = string
  default = "dev"
}

variable "name" {
  type = string
}

variable "container_name" {
  type    = string
  default = "Items"
}

variable "location" {
  type    = string
  default = "northeurope"
}

variable "resource_group" {
  type = string
}

variable "throughput" {
  type    = number
  default = 1000
  validation {
    condition     = var.throughput >= 1000 && var.throughput <= 1000000 && var.throughput % 1000 == 0
    error_message = "Invalid cosmos db throughput value"
  }
}
