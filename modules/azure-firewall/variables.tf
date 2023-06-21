variable "name" {
  description = "The name of the Vnet"
}

variable "virtual_network_name" {
  description = "The name of the Vnet"
}

variable "resource_group_name" {
  description = "The resource group containing the vnet"
}

variable "location" {
  description = "Location"
}

variable "firewall_subnet_id" {
  description = "The subnet"
}
