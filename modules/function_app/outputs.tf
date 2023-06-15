output "function_url" {
  value = azurerm_windows_function_app.function_app.default_hostname
}

output "app_service_plan_id" {
  value = module.app_service_plan.app_service_plan_id
}

output "function_app_id" {
  value = azurerm_windows_function_app.function_app.id
}
