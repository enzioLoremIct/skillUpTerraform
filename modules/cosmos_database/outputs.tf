output "name" {
  value = azurerm_cosmosdb_account.cosmos_account.name
}

output "database_name" {
  value = azurerm_cosmosdb_sql_database.database.name
}

output "collection" {
  value = var.container_name
}

output "database_access_strings" {
  value = azurerm_cosmosdb_account.cosmos_account.connection_strings
}

output "account_endpoint" {
  value = azurerm_cosmosdb_account.cosmos_account.endpoint
}

output "account_key" {
  value = azurerm_cosmosdb_account.cosmos_account.primary_key
}
