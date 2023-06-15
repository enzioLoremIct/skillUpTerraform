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

variable "app_service_plan_id" {
  type = string
}
