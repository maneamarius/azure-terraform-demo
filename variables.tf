# Azure Authentication params
variable "azure-subscription-id" {
  type        = string
  description = "Azure Subscription Id"
}
variable "azure-client-id" {
  type        = string
  description = "Azure Client Id/appId"
}
variable "azure-client-secret" {
  type        = string
  description = "Azure Client Id/appId"
}
variable "azure-tenant-id" {
  type        = string
  description = "Azure Tenant Id"
}


# Module variables
variable "name" {
  type     = string
  description = "resource group name"
}

variable "location" {
  type     = string
  description = "resource group location"
}
 
variable "tags" {
  type        = map(string)
  description = "KV pairs of tag names and values for the resource group"
  default = {}
}
