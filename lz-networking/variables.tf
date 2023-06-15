
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

variable "hub_prefix" {

}

variable "hub_address_space" {
    
}

variable "firewall_subnet_address_space" {
    
}

variable "bastion_subnet_address_space" {
  
}

variable "applicationgw_subnet_address_space" {
  
}

variable "jumpbox_subnet_address_space" {
  
}

variable "aks_spoke_cidr" {
  
}

variable "sku_name" {
  default = "AZFW_VNet"
}

variable "sku_tier" {
  default = "Standard"
}

variable "kv_sku_name" {
    description = "KV Sku"
    default = "premium"
}

variable "admin_password" {
  type = string
  
}

variable "aks_spoke1_address_space" {
  
}

variable "aks_spoke2_address_space" {
  
}
variable "aks_subnet_address_space" {
  
}
variable "aks_subnet2_address_space" {
  
}

variable "plendpoints_subnet_address_space" {
  
}
variable "plendpoints_subnet2_address_space" {
  
}