
# # Create resource group
# resource "azurerm_resource_group" "poc_rg" {
#   name     = var.resource_group_name
#   location = var.location
# }

# # Create storage account
# resource "azurerm_storage_account" "sa" {
#   name                     = var.storage_account_name
#   resource_group_name      = azurerm_resource_group.poc_rg.name
#   location                 = azurerm_resource_group.poc_rg.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

# # Create Function App Plan
# resource "azurerm_function_app_plan" "app_plan" {
#   name                = "appserviceplan"
#   resource_group_name = azurerm_resource_group.poc_rg.name
#   location            = azurerm_resource_group.poc_rg.location
#   kind                = "FunctionApp"
#   sku {
#     tier = "Dynamic"
#     size = "Y1"
#   }
# }

# # Create Function App
# resource "azurerm_function_app" "function_app" {
#   name                       = var.function_app_name
#   resource_group_name        = azurerm_resource_group.poc_rg.name
#   location                   = azurerm_resource_group.poc_rg.location
#   app_service_plan_id        = azurerm_function_app_plan.app_plan.id
#   storage_account_name        = azurerm_storage_account.sa.name
#   storage_account_access_key = azurerm_storage_account.sa.primary_access_key
# }

# # Deploy Function App code
# resource "azurerm_function_app_blob" "function_blob" {
#   name                      = "${azurerm_function_app.function_app.name}/zipdeploy"
#   storage_account_name      = azurerm_storage_account.sa.name
#   storage_account_access_key = azurerm_storage_account.sa.primary_access_key
#   type                      = "functionapp"
#   source_path               = "path/to/your/function/app/code.zip"  # Path to your function app code
#   content_type              = "application/zip"
# }
# Generate random text for a unique storage account name
resource "random_id" "random_id" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group_name = module.rg.resource_group_name
  }

  byte_length = 8
}
module "rg" {
  source                    = "./modules/rg"
  resource_group_name  = "sa1_test_eic_TejalDave"
  location                  = "southeastasia"

  
}

module "blob" {
  source = "./modules/blob"
  storage_account_name = "diag${random_id.random_id.hex}"
  account_tier = "Standard"
  account_replication_type = "LRS"
  resource_group_name = module.rg.resource_group_name
  location = module.rg.location
  
}

module "insight" {
  source              = "./modules/insight"
  app_insights     = "application_insight"
  location            = module.rg.location
  resource_group_name = module.rg.resource_group_name
  application_type    = "Node.JS"
}
#https://www.maxivanov.io/deploy-azure-functions-with-terraform/S

module "app_service_plan" {
  source = "./modules/service_plan"
  service_plan_name = "diag-service-plan"
  resource_group_name = module.rg.resource_group_name
  location = module.rg.location
  //app_service_plan_id = azurerm_app_service_plan.app_service_plan.app_service_plan_id

}

module "function" {
  source = "./modules/function"
  resource_group_name = module.rg.resource_group_name
  location = module.rg.location
  app_service_plan_id = module.app_service_plan.app_service_plan_id
  storage_account_name = module.blob.storage_account_name
  primary_access_key = module.blob.primary_access_key
  appinsight_instrumentkey = module.insight.instrumentation_key

}
