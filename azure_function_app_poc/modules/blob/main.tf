#Create storage account
resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name           #azurerm_resource_group.poc_rg.name
  location                 = var.location                       #azurerm_resource_group.poc_rg.location
  account_tier             = var.account_tier #"Standard"
  account_replication_type = var.account_replication_type #"LRS"
}
# resource "azurerm_storage_account" "storage_account" {
#   name = "diag${random_id.random_id.hex}"
#   resource_group_name = azurerm_resource_group.resource_group.name
#   location = var.location
#   account_tier = "Standard"
#   account_replication_type = "LRS"
# }