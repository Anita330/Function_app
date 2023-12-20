resource "azurerm_application_insights" "application_insights" {
  name                = var.app_insights
  location            = var.location
  resource_group_name = var.resource_group_name
  application_type    = var.application_type  #"Node.JS"
}