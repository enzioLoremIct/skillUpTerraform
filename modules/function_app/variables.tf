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

variable "allowed_urls" {
  type    = list(string)
  default = []

  /*validation {
    //just dont type any goddamn invalid urls
    condition     = true
    error_message = "no"
  }*/
}

//variable "database_name" {
//  type = string
//}

variable "account_endpoint" {
  type = string
}

variable "account_key" {
  type = string
}
