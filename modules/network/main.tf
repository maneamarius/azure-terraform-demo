terraform {
  required_providers {
    azurerm = ">= 2.8.0" // For move to address_prefixes
  }
}

resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = var.resource_group
  location            = var.location
  tags                = var.tags
  depends_on          = [var.module_depends_on]

  address_space = var.address_space
  dns_servers   = var.dns_servers

  lifecycle {
    ignore_changes = [tags]
  }
}

resource "azurerm_subnet" "subnet" {
  resource_group_name  = var.resource_group
  virtual_network_name = azurerm_virtual_network.vnet.name

  for_each = var.subnets

  name              = each.key
  address_prefixes  = flatten([each.value])
  service_endpoints = null
}
