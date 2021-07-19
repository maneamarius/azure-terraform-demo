variable "name" {
  type     = string
  description = "adf name"
}

variable "location" {
  type     = string
  description = "adf location"
}

variable "resource_group_name" {
  type     = string
  description = "resource group for adf to be created in"
}

variable "tags" {
  type        = map(string)
  description = "KV pairs of tag names and values for the adf"
}
