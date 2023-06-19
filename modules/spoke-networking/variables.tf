
#############
# VARIABLES #
#############

variable "location" {
    
}

variable "tags" {
  type = map(string)

  default = {
    project = "cs-aks"
  }
}

variable "enable_dns_from_firewall" {
  type    = bool
  default = false
}

variable "hub_resource_group_name" {
  type = string
}

variable "spoke_name" {
  type = string
}

variable "spoke_address_space" {
  type = string
}

variable "firewall_private_ip_address" {
  type = string
}

variable "node_subnet_address_space" {
  type = string
}

variable "pod_subnet_address_space" {
  type = string
}

variable "plendpoints_subnet_address_space" {
  type = string 
}

variable "hub_vnet_name" {
  type = string 
}

variable "hub_vnet_id" {
  type = string 
}

variable "kv_sku_name" {
    description = "KV Sku"
    default = "premium"
}

variable "private_dns_zones" {
    description = "List of DNS Zones that must be linked to this vnet"
    type = list(object({
        name                     = string                
    }))
    default = []
}
