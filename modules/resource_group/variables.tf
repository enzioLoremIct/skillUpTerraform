variable "stage" {
  type        = string
  default     = "dev"
  description = "Staging grounds."
}

variable "name" {
  type = string
}

variable "service" {
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
