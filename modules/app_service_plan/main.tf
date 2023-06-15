resource "azurerm_storage_account" "storage_account" {
  //TODO ensure name length is >= 3 && <= 24
  name                     = "${var.stage}0str0${var.name}0${random_string.suffix.id}"
  resource_group_name      = var.resource_group
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "app_service_plan" {
  name                = "asp-${var.name}"
  resource_group_name = var.resource_group
  location            = var.location
  os_type             = var.os_type
  sku_name            = var.sku_name //F1 for free, D1 for shared, B1, for basic, S1 for standard, Y1 for serverless functions
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}
