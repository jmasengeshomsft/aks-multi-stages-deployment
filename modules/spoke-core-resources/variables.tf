
variable "default_location" {
    description = "The default location"
    type        = string
}

variable "spoke_resource_group_name" {
    description = "The name of the resource group for acr, key vault and storage accounts"
    type        = string
}

variable "hub_resource_group_name" {
    description = "The name of the resource group for networking"
    type        = string
}

variable "hub_vnet_name" {
  description = "The name of the Vnet"
  type        = string
}  
# variable "hub_default_subnet_address_space" {
#   description = "The default subnet address space"
# }

variable "spoke_vnet_name" {
  description = "The name of the Vnet"
  type = string
}

variable "private_link_subnet_id" {
  description = "The name of private link subnet"
  type = string
}

#key vault
variable "key_vault_name" {
   description = "The name of the key vault"
}

variable "key_vault_sku_name" {
   description = "Sku Name"
   default     = "standard"
}

variable "key_vault_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.vaultcore.azure.net"
}

variable "law_name" {
    description = "The name of the law"
}

#ACR
variable "acr_name" {
    description = "The name of the container registry"
}

variable "geo_replication_region" {
    description = "ACR georeplication"
    default     = "centralus"
}

variable "acr_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.azurecr.io"
}

#storage account
variable "storage_account_name" {
    description = "The name of the storage account"
}

variable "azure_file_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.file.core.windows.net"
}

# #TAGGING
variable "environment" {
  type        = string
  description = "Environment name, e.g. 'dev' or 'stage'"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
      "appName" = "privatek8s"
  }
}


