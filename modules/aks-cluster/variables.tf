variable "resource_group_name" {
    description = "Application Gateway Resource Group"
}

variable "location" {
    description = "cluster location"
}

variable "virtual_network_name" {
    description = "The name of the vnet"
}

variable "vnet_resource_group_name" {
    description = "The name of the vnet"
}

variable "aks_subnet_id" {
    description = "The id of the subnet to attach to the udr"
}

variable "pod_subnet_id" {
    description = "The id of the subnet to attach to the udr"
    default = null
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
}

# variable "private_dns_zone_id" {
#     description = "The ID of the DNS Zone for the Private Link"
# }

variable "kubernetes_version" {
    description = "Kubernetes version"
}

variable "default_node_count" {
    description = "Pool node count"
    default     = 3
}

variable "azurerm_log_analytics_workspace_id" {
    description = "The id of the log analytics woskpace"
}

variable "default_pool_max_pods" {
    description = "The number of pods on the default node pool"
    default     = 200
}

variable "sku_tier" {
  description = "Use Uptime SLA or Not"
  default = "Free"
}

# variable "default_pod_subnet_id" {
#     description = "The subnet for pods on the default pool"
# }

variable "default_vm_size" {
    description = "VM Size"
    default     = "Standard_D2_v2"
}

variable "node_pool_type" {
    description = "VM type: AvailabilitySet or VirtualMachineScaleSets"
    default     = "VirtualMachineScaleSets"
}

# variable "service_principal_client_id" {
#     description = "The client id for the service principal "
# }

# variable "service_principal_client_secret" {
#     description = "The client secret for the service principal"
# }


variable "network_plugin" {
    description = "The network plugin: Azure/Kubenet"
    default     = "kubenet"
}

variable "network_plugin_mode" {
    description = "The network plugin mode: Overlay"
    default     = null
}

variable "ebpf_data_plane" {
    description = "Specifies the eBPF data plane used for building the Kubernetes network"
    default     = null
}

variable "network_policy" {
    description = "The network plugin: Azure/Kubenet"
    default     = "calico"
}

variable "pod_cidr" {
    description = "Pod Address Space"
    # default     = "10.244.0.0/16"
}

# variable "docker_bridge_cidr" {
#     description = "Docker Address Space"
#     # default     = "172.17.0.1/16"
# }

variable "service_cidr" {
    description = "Service Address Space"
    # default     = "10.240.0.0/16"
}

variable "dns_service_ip" {
    description = "Service Address Space"
    # default     = "10.240.0.10"
}

variable "outbound_type" {
    description = "Out bound type: userDefinedRouting/loadBalancer"
    default     = "userDefinedRouting"
}

variable "tenant_id" {
    description = "Tenant aad"
}

variable "azure_aad_admin_group_id" {
    description = "The default aad group"
    default = null
}

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {
  }
}
