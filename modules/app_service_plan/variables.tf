variable "stage" {
  type    = string
  default = "dev"

  validation {
    condition     = contains(["dev", "test", "prod"], var.stage)
    error_message = "Invalid staging ground."
  }
}

variable "name" {
  type = string
}

variable "resource_group" {
  type = string
}

variable "location" {
  type    = string
  default = "northeurope"

  validation {
    condition     = contains(["northeurope", "switzerlandnorth"], var.location)
    error_message = "Invalid location."
  }
}

variable "os_type" {
  type = string

  validation {
    condition     = contains(["Windows", "Linux"], var.os_type)
    error_message = "Invalid os type selected."
  }
}

variable "sku_name" {
  type = string
}
