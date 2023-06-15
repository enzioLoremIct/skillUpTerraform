module "resource_group" {
  source = "../resource_group"

  stage    = "dev"
  name     = var.name
  service  = "Storage"
  location = var.location
}

resource "azurerm_cosmosdb_account" "cosmos_account" {
  name                      = "${var.stage}-dbacc-${var.name}-${random_string.suffix.id}"
  location                  = var.location
  resource_group_name       = module.resource_group.name
  offer_type                = "Standard"
  kind                      = "GlobalDocumentDB"
  enable_automatic_failover = false
  enable_free_tier          = true
  geo_location {
    location          = var.location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }

  lifecycle {
    prevent_destroy = true
  }
}

resource "azurerm_cosmosdb_sql_database" "database" {
  name                = var.name
  resource_group_name = module.resource_group.name
  account_name        = azurerm_cosmosdb_account.cosmos_account.name
  autoscale_settings {
    max_throughput = var.throughput
  }
}

resource "azurerm_cosmosdb_sql_container" "container" {
  name                  = var.container_name
  resource_group_name   = module.resource_group.name
  account_name          = azurerm_cosmosdb_account.cosmos_account.name
  database_name         = azurerm_cosmosdb_sql_database.database.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  autoscale_settings {
    max_throughput = var.throughput
  }

  //indexing_policy {}
}

resource "random_string" "suffix" {
  length = 8
  upper  = false
  //Cannot have special characters in CosmosDB account name
  special = false
  //override_special = "!@#$%&"
}
