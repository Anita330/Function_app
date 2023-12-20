

# Function App Plan
# resource "azurerm_app_service_plan" "primary" {
#   name                     = var.function_app_plan #"funcappplan"
#   resource_group_name      = var.resource_group_name
#   location                 = var.location
#   kind                     = "Linux"
#   reserved                 = true
#   maximum_elastic_worker_count = 1
#   sku {
#     tier = "Dynamic"
#     size = "Y1"
#   }
# }

# resource "azurerm_consumption_plan" "plan" {
#   name               = var.consumption_plan #"funcappplan"
#   location           = var.location 
#   resource_group_name = var.resource_group_name
# }
# Function App
# resource "azurerm_function_app" "function_app" {
#   name                       = var.consumption_plan
#   resource_group_name        = var.resource_group_name
#   location                   = var.location 
#   app_service_plan_id        = var.app_service_plan_id #"consumption"  # This is a special value for Consumption Plan
#   //storage_account_name       = var.storage_account_name #azurerm_storage_account.storage.name
#   //storage_account_access_key = azurerm_storage_account.storage.primary_access_key
# }

resource "azurerm_function_app" "function_app" {
  name                       = "diag-function-app"
  resource_group_name        = var.resource_group_name
  location                   = var.location
  app_service_plan_id        = var.app_service_plan_id
  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE" = "",
    "FUNCTIONS_WORKER_RUNTIME" = "Python",
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.appinsight_instrumentkey, #azurerm_application_insights.app_insights.instrumentation_key
  }
  os_type = "linux"
  site_config {
    linux_fx_version          = "Python|3.11"
    use_32_bit_worker_process = false
  }
  storage_account_name       = var.storage_account_name
  storage_account_access_key = var.primary_access_key
  version                    = "~4"

  lifecycle {
    ignore_changes = [
      app_settings["WEBSITE_RUN_FROM_PACKAGE"],
    ]
  }
}




# # Azure Functions Code
# resource "azurerm_function_app_slot" "function_app_code" {
#   name                = "production"
#   resource_group_name = azurerm_resource_group.rg.name
#   function_app_id     = azurerm_function_app.function_app.id
#   source_control {
#     repo_url = "https://github.com/Azure-Samples/functions-quickstart"
#     branch   =

#   }