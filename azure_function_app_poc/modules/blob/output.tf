# output "location" {
#   value = azurerm_resource_group.poc_rg.location
# }
# output "resource_group_name" {
#   value = azurerm_resource_group.poc_rg.name
# }
output "storage_account_name" {
  value = azurerm_storage_account.sa.name
}
output "primary_access_key" {
  value = azurerm_storage_account.sa.primary_access_key
}