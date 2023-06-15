#############################################################################
# VARIABLES
#############################################################################

variable "location" {
  type    = string
  default = "northeurope"
}

variable "naming_prefix" {
  type    = string
  default = "skillup"
}

variable "github_repository" {
  type    = string
  default = "skillUpTerraform"
}