
#############
# VARIABLES #
#############

# Wether or not to use the firewall as the DNS resolver.  DOES NOT work with BASIC firewall
variable enable_dns_from_firewall {
  default = false
  type = bool
}

variable "location" {
    
}

variable "tags" {
  type = map(string)

  default = {
    project = "cs-aks"
  }
}

variable "hub_prefix" {

}

variable "hub_address_space" {
    
}

variable "firewall_subnet_address_space" {
    
}

variable "mgmt_firewall_subnet_address_space" {
    
}

variable "bastion_subnet_address_space" {
  
}

variable "applicationgw_subnet_address_space" {
  
}

variable "jumpbox_subnet_address_space" {
  
}

variable "aks_spoke_address_space" {
  
}

variable "fw_sku_name" {
  default = "AZFW_VNet"
}

variable "fw_sku" {
  default = "Standard"
  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.fw_sku)
    error_message = "Accepted values are 'Basic', 'Standard', 'Premium'"
  }
}

variable "fw_policy_sku" {
  default = "Standard"
  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.fw_policy_sku)
    error_message = "Accepted values are 'Basic', 'Standard', 'Premium'"
  }
}

variable "kv_sku_name" {
    description = "KV Sku"
    default = "Standard"
}

variable "admin_password" {
  type = string
  default = ""
  
}

# variable "node_subnet_address_space" {
  
# }

# variable "pod_subnet_address_space" {
  
# }

variable "plendpoints_subnet_address_space" {
  
}

variable "default_spoke_name" {
  type = string
}
