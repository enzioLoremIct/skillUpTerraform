resource "azurerm_resource_group" "dev-azurerm-test-group" {
  name     = "${var.stage}-rsg-${var.name}"
  location = var.location
  tags = {
    Service = "${var.service}"
    Stage   = "${var.stage}"
  }
}
