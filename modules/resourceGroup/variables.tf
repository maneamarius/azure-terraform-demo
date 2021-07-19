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
  default     = {}
}
