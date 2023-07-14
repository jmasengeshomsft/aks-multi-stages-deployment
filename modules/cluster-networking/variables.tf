
variable "spoke_resource_group_name" {
    description = "The name of the resource group for acr and key vault"
    type        = string
}

variable "spoke_vnet_name" {
  description = "The name of the Vnet"
  type = string
}

variable "aks_subnet_name" {
    description = "The name of the subnet to attach to the udr"
}

variable "node_subnet_address_space" {
  type = string
}

variable "nodes_nsg_name" {
    description = "The name of the nsg for the nodes subnet"
}


# variable "pod_subnet_name" {
#     description = "The name of the subnet to attach to the udr"
# }

# variable "pod_subnet_address_space" {
#   type = string
# }


# variable "pods_nsg_name" {
#     description = "The name of the nsg for the pods subnet"
# }


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