variable "resource_group_name" {
    description = "The name of the vnet resource group"
}

variable "virtual_network_name" {
    description = "The name of the vnet"
}

variable "dns_zone_name" {
    description = "DNS ZOne name"
}

variable "virtual_network_id" {
    description = "The Id of the Virtual Network"
 }

# variable "dns_name_ip_value" {
#     description = "DNS value IP address"
# }

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}