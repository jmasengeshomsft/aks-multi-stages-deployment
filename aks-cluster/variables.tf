
variable "location" {
    description = "The default location"
    type        = string
}

variable "environment" {
  type        = string
  description = "Environment name, e.g. 'dev' or 'stage'"
}

variable "spoke_name" {
  description = "The name of the spoke"
  type = string
}

variable "hub_resource_group_name" {
    description = "The name of the resource group for networking"
    type        = string
}

# variable "spoke_networking_resource_group_name" {
#     description = "The name of the resource group for networking"
#     type        = string
# }

variable "spoke_resource_group_name" {
    description = "The name of the resource group for acr and key vault"
    type        = string
}

variable "spoke_vnet_name" {
  description = "The name of the Vnet"
  type = string
}

variable "hub_vnet_name" {
    description = "The name of the vnet"
}

variable "firewall_name" {
  description = "The name of the firewall resource"
  type = string
}

variable "aks_subnet_name" {
    description = "The name of the subnet to attach to the udr"
}

variable "pod_subnet_name" {
    description = "The name of the subnet to attach to the udr"
    default = null
}

variable "privatelink_subnet_name" {
    description = "The name of the subnet to attach to the nodepool- linux"
}

variable "public_ssh_key" {
  description = "A custom ssh key to control access to the AKS cluster"
  default     = ""
}

variable "linux_admin_user" {
    description = "admin user"
    default     = "azureadminuser"
}

variable "aks_cluster_name" {
    description = "The name of the cluster"
    default     = "aks-terraform-001"
}

# variable "workload_vm_size" {
#     description = "Workload vm sizes"
#     default     =  "Standard_D2_v2"
# }

# variable "default_nodepool_subnet" {
#     description = "Default subnet"
# }

variable "default_pool_max_pods" {
    description = "The number of pods on the default node pool"
    default     = 50
}

# variable "workload_pool_max_pods" {
#     description = "The number of pods on the workload node pool"
#     default     = 50
# }

variable "default_node_count" {
    description = "Pool node count"
    default     = 1
}

# variable "workload_node_count" {
#     description = "Pool node count"
#     default     = 2
# }

variable "default_vm_size" {
    description = "VM Size"
    default     = "Standard_D2_v2"
}

variable "node_pool_type" {
    description = "VM type: AvailabilitySet or VirtualMachineScaleSets"
    default     = "VirtualMachineScaleSets"
}

variable "network_plugin" {
    description = "The network plugin: Azure/Kubenet"
    default     = "azure"
}

variable "network_plugin_mode" {
    description = "The network mode: Overlay"
    #default     = "Overlay"
    default     = null
}

variable "ebpf_data_plane" {
    description = "Specifies the eBPF data plane used for building the Kubernetes network"
    default     = "cilium"
}

variable "network_policy" {
    description = "The network plugin: Azure/Kubenet"
    default     = "calico"
}

variable "docker_bridge_cidr" {
    description = "Docker Address Space"
    default     = "10.245.0.1/16"
}
# variable "workspace_name" {
#     description = "The name of the log analytics workspace"
# }

variable "aad_tenant_id" {
    description = "The id of the tenant"
    default     = ""
}

variable "azure_aad_admin_group_id" {
    description = "Default group member"
    default     = ""
}

# variable "workspace_resource_group_name" {
#     description = "The resource group for the analytics worspace"
# }

variable "pod_cidr" {
    description = "Pod Address Space"
    default     = "10.244.0.0/16"
}

variable "service_cidr" {
    description = "Service Address Space"
    default     = "10.240.0.0/16"
}

variable "dns_service_ip" {
    description = "Service Address Space"
    default     = "10.240.0.10"
}

variable "kubernetes_version" {
    description = "AKS Version - Optional"
    # default     = "1.22.6"
}

variable "outbound_type" {
    description = "Out bound type: userDefinedRouting/loadBalancer"
    default     = "userDefinedRouting"
}


//container registry
# variable "privatelink_subnet_name" {
#     description = "The name of the subnet to attach private link based resources"
# }

# variable "acr_name" {
#     description = "The name of the container registry"
# }

# variable "storage_account_name" {
#     description = "The name of the storage account"
# }


variable "acr_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.azurecr.io"
}

# variable "key_vault_name" {
#    description = "The name of the key vault"
# }

# variable "tls_key_vault_name" {
#    description = "The name of the key vault for tls certs"
# }

# variable "tls_key_vault_resource_group" {
#    description = "The name of the key vault for tls certs"
# }

# variable "file_share_storage_name" {
#    description = "The name of the aks file share"
# }


variable "key_vault_sku_name" {
   description = "Sku Name"
   default     = "standard"
}


variable "key_vault_dns_zone_name" {
    description = "DNS Zone name"
    default     = "privatelink.vaultcore.azure.net"
}


# variable "aks_nsg_rules" {
#   type = list(object({
#     name                        = string
#     priority                    = number
#     direction                   = string
#     access                      = string
#     protocol                    = string
#     source_port_range           = string
#     destination_port_range      = string
#     source_address_prefix       = string
#     destination_address_prefix  = string
#     description                                 = string
#     destination_address_prefixes                = list(string)
#     destination_application_security_group_ids  = list(string)
#     destination_port_ranges                     = list(string)
#     source_address_prefixes                     = list(string)
#     source_application_security_group_ids       = list(string)
#     source_port_ranges                          = list(string)
#   }))
#   default = []
# }

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
      "appName" = "privatek8s"
  }
}

# variable "aks_dns_zone_name" {
#     description = "DNS Zone name"
#     default     = "privatelink.centralus.azmk8s.io"
# }
