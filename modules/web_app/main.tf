resource "azurerm_windows_web_app" "web_app" {
  name                = "${var.stage}-wa-${var.name}-${random_string.suffix.id}"
  location            = var.location
  resource_group_name = var.resource_group
  service_plan_id     = var.app_service_plan_id

  site_config {
    //scm_type = "GitHub"
  }

  app_settings = {
    "ENABLE_ORYX_BUILD"              = true
    "SCM_DO_BUILD_DURING_DEPLOYMENT" = true
  }
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}
