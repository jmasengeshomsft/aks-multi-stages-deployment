variable "resource_group_name" {
    description = "KV Resource Group"
}

variable "location" {
    description = "KV Location"
}

variable "key_vault_name" {
    description = "KV Name"
}

variable "key_vault_subnet_id" {
    description = "KV Subnet Id"
}

variable "sku_name" {
    description = "KV Sku"
    default = "premium"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}