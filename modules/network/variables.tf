variable "resource_group" {
  type        = string
  description = "Name of an existing resource group to deply the virtual network into."
}

variable "location" {
  type        = string
  description = "The Azure region to deploy to. Recommendation is to set to the same location as the resource group."
  default     = ""
}

variable "tags" {
  type        = map
  description = "Map of key value pairs for the resource tagging. Default: none."
  default     = {}
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network (vNet) to create."
}

variable "address_space" {
  type        = list(string)
  description = "Array containing the IPv4 address space for the virtual network in. Default is [\"10.0.0.0/16\"]."
  default     = ["10.0.0.0/16"]
}

variable "dns_servers" {
  type        = list(string)
  description = "Array of IP addresses for custom DNS servers. Default: none, i.e. use Azure DNS."
  default     = null
}

variable "subnets" {
  type        = map(string)
  description = "Map of subnet names to address prefixes. Default: none."
  default     = {}
}

variable "module_depends_on" {
  type    = any
  default = null
}
