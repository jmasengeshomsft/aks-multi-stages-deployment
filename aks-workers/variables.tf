variable "aks_cluster_name" {
  type = string
}

variable "aks_cluster_resource_group" {
  type = string
}

variable "host_group_id" {
  type    = string
  default = null
}

variable "pod_subnet_name" {
    description = "The name of the subnet to attach to the udr"
}

variable "node_subnet_name" {
    description = "The name of the subnet to attach to the udr"
}


variable "spoke_resource_group_name" {
    description = "The name of the resource group for acr and key vault"
    type        = string
}

variable "spoke_vnet_name" {
  description = "The name of the Vnet"
  type = string
}