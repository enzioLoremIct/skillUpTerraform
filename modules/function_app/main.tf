module "app_service_plan" {
  source = "../app_service_plan"

  stage          = var.stage
  name           = var.name
  resource_group = var.resource_group
  location       = var.location
  os_type        = "Windows"
  sku_name       = "Y1"
}

resource "azurerm_windows_function_app" "function_app" {
  name                = "${var.stage}-fa-${var.name}-${random_string.suffix.id}"
  resource_group_name = var.resource_group
  location            = var.location

  storage_account_name       = module.app_service_plan.storage_account_name
  storage_account_access_key = module.app_service_plan.storage_account_access_key
  service_plan_id            = module.app_service_plan.app_service_plan_id

  /*app_settings = {
    FUNCTIONS_EXTENSION_VERSION              = "~3"
    FUNCTIONS_WORKER_RUNTIME                 = "node"
    WEBSITE_CONTENTAZUREFILECONNECTIONSTRING = module.app_service_plan.storage_account_access_key
    WEBSITE_CONTENTSHARE                     = module.app_service_plan.storage_account_name
    //COSMOSDB_CONNECTION_STR                  = module//azurerm_cosmosdb_account.db.connection_strings[0]
  }*/

  app_settings = {
    COSMOS_DATABASE_CONNECTION = "AccountEndpoint=${var.account_endpoint};AccountKey=${var.account_key};"
    COSMOS_DATABASE_ENDPOINT   = var.account_endpoint
    COSMOS_DATABASE_KEY        = var.account_key
  }

  site_config {
    application_stack {
      node_version = "~18" //must be "~<version>" for Windows, and "<version>" for Linux, for whatever fucking reason
    }
    cors {
      allowed_origins = concat(
        [
          "https://portal.azure.com",
          "https://127.0.0.1:3000",
          "https://functions.azure.com"
        ],
        var.allowed_urls
      )
    }
  }
}

resource "random_string" "suffix" {
  length  = 4
  upper   = false
  special = false
}
