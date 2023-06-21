variable "acr_name" {
    description = "The name of the container registry"
}

variable "sku_name" {
    description = "The tier for the container registry"
    default     = "Premium"
} 

variable "acr_subnet_id" {
    description = "The ACR Subnet Id"
}

# variable "geo_replication_region" {
#     description = "ACR georeplication"
# }

variable "resource_group_name" {
    description = "The name of registry"
}

variable "location" {
    description = "The location of the registry"
}

variable "private_zone_id" {
    description = "The Zone Id for ACR Private Link"
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}