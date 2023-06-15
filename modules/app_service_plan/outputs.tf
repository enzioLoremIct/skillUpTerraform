output "storage_account_name" {
  value = azurerm_storage_account.storage_account.name
}

output "storage_account_access_key" {
  value = azurerm_storage_account.storage_account.primary_access_key
}


output "app_service_plan_id" {
  value = azurerm_service_plan.app_service_plan.id
}
