
variable "spoke_resource_group_name" {
    description = "The name of the resource group for acr and key vault"
    type        = string
}

variable "aks_cluster_name" {
  description = "The name of the AKS cluster"
  type        = string
}

variable "spoke_vnet_name" {
  description = "The name of the Vnet"
  type = string
}

variable "node_subnet_address_space" {
  type = string
}

variable "pod_subnet_address_space" {
  type = string
}

variable "route_table_name" {
    description = "The name of the spoke route table"
    type      = string
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
      "appName" = "privatek8s"
  }
}