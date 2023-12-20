# Output the Function App URL
output "function_app_url" {
  value = azurerm_function_app.function_app.default_hostname
}

# output "app_service_plan_id" {
#     value = azurerm_function_app.function_app.app_service_plan_id
  
# }