variable "resource_group_name" {
    description = "The name of the vnet resource group"
}

variable "dns_zone_name" {
    description = "DNS ZOne name"
}

variable "dns_a_record_name" {
    description = "A record name"
}

variable "dns_name_ip_value" {
    description = "DNS value IP address"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}