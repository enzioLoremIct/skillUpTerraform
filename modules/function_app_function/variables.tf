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

  validation {
    condition     = can(regex("^[0-9A-Za-z-]+$", var.name)) //^[[:alnum:]]+$ filters alphanumerics, but no hyphens
    error_message = "Function name invalid, must only contain alphanumeric characters and hyphens."
  }
}

variable "function_app_id" {
  type = string
}

variable "script" {
  type = string
}

variable "config" {
  //type = object({})
}
