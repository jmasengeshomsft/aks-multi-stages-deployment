variable "resource_group_name" {
  description = "Resource Group Name for Fw policy"
  type        = string
}

variable "location" {
  description = "Location for AKS FW Policy"
  type        = string
}

variable "aks_spoke_address_space" {
  description = "Cidr of AKS Spoke Subnet"
  type        = string
}

variable "fw_policy_sku" {
  description = "Type of Firewall SKU"
  type        = string
  validation {
    condition = contains(["Basic", "Standard", "Premium"], var.fw_policy_sku)
    error_message = "Accepted values are 'Basic', 'Standard' or 'Premium'"
  }
}

variable "jumpbox_subnet_address_space" {
  description = "Cidr of jumpbox subnet"
  type        = string
}

