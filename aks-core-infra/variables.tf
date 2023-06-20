variable "environment" {
  type = string
}

# variable "spoke_name" {
#   type = string
# }

# variable "spoke_resource_group_name" {
#     description = "The name of the resource group for acr and key vault"
#     type        = string
# }

# variable "spoke_vnet_name" {
#   description = "The name of the Vnet"
#   type        = string
# }  

variable "hub_resource_group_name" {
    description = "The name of the resource group for networking"
    type        = string
}

variable "hub_vnet_name" {
  description = "The name of the Vnet"
  type        = string
}  

variable "privatelink_subnet_name" {
    description = "The name of the subnet to attach to the nodepool- linux"
}


variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
      "appName" = "aks-play-ground"
  }
}

variable "key_vault_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.vaultcore.azure.net"
}
variable "acr_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.azurecr.io"
}

variable "key_vault_sku_name" {
   description = "Sku Name"
   default     = "standard"
}


variable "azure_file_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.file.core.windows.net"
}
