# variable "consumption_plan" {
#   type = string
#   description = "name of service plan"
# }
variable "resource_group_name" {
  type = string
  description = "name of resource group"
}
variable "location" {
  type = string
  description = "name of location"
}
variable "app_service_plan_id" {
    type = string
    description = "name of service plan id"
  
}
variable "storage_account_name" {
    type = string
    description = "name of storage account"
  
}

variable "primary_access_key" {
  type = string
}
variable "appinsight_instrumentkey" {
  type = string
}