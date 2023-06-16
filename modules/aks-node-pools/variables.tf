#
# Cluster Info
#

variable "aks_cluster_name" {
  description = "An existing AKS cluster name"
  type        = string
}

variable "aks_cluster_resource_group" {
  description = "Resource Group existing cluster lives in"
  type        = string
}

#
# Worker pools
#

variable "worker_vm_sku" {
  default     = "Standard_D2s_v3"
  description = "Size of the VM to use for this worker pool"
  type        = string 
}

variable "worker_pool_name" {
  default     = null 
  description = "Name of worker pool"
  type        = string 
}

variable "worker_pool_mode" {
  default     = "User"
  description = "Type of worker pool.  Can be one of 'User' or 'System'"
  type        = string 
}

variable "worker_pool_size" {
  default     = 1
  description = "Initial size for worker pools when unspecified on a pool."
  type        = number
  validation {
    condition     = var.worker_pool_size > 0 && var.worker_pool_size <= 1000
    error_message = "Must be between 1 and 1000."
  }
}

variable "worker_pool_min_count" {
  default     = 1
  description = "Minimum number of nodes which should exist in nodepool"
  type        = number
  validation {
    condition     = var.worker_pool_min_count > 0 && var.worker_pool_min_count <= 1000
    error_message = "Must be between 1 and 1000."
  }
}

variable "worker_pool_max_count" {
  default     = 1
  description = "Maximum number of nodes which should exist in nodepool"
  type        = number
  validation {
    condition     = var.worker_pool_max_count > 0 && var.worker_pool_max_count <= 1000
    error_message = "Must be between 1 and 1000."
  }
}

variable "worker_node_labels" {
  default     = {}
  description = "Default worker node labels. Merged with labels defined on each pool."
  type        = map(string)
}

variable "host_group_id" {
  default     = null
  description = "Host Group Id for dedicated hardware used by this node pool"
  type        = string
}

variable "tags" {
  default     = {}
  description = "Tags to apply to the worker node resources."
  type        = map(string)
}

variable "worker_node_metadata" {
  default     = {}
  description = "Map of additional worker node instance metadata. Merged with metadata defined on each pool."
  type        = map(string)
}

variable "worker_is_public" {
  default     = false
  description = "Whether to provision workers with public IPs allocated by default when unspecified on a pool."
  type        = bool
}

variable "worker_node_taints" {
  default     = null
  description = "Taints that will be applied to the worker pool nodes"
  type        = string
}

variable "worker_pool_node_priority" {
  default     = "Regular" 
  description = "Priority for virtual machines 'Regular' or 'Spot'"
  type        = string
  validation {
    condition = contains(["Regular", "Spot"], var.worker_pool_node_priority)
    error_message = "Accepted values are 'Spot' or 'Regular'"
  }
}

variable "enable_node_public_ip" {
  default     = false
  description = "Whether nodes should have a public ip address or not"
  type        = bool
}

variable "pod_subnet_id" {
  default     = null
  description = "If this is defined the subnet the pods will be provisioned in"
  type        = string
}

variable "vnet_subnet_id" {
  default     = null
  description = "If this is defined the subnet the worker nodes will be provisioned in"
  type        = string
}

variable "worker_os_type" {
  default     = "Linux"
  description = "Type of OS for worker pool"
  type        = string
  validation {
    condition = contains(["Linux", "Windows"], var.worker_os_type)
    error_message = "Accepted values are 'Linux' or 'Windows'"
  }
}

variable "worker_os_sku" {
  default     = "Ubuntu"
  description = "Type of OS Sku for this worker pool.  One of 'Ubuntu', 'CBLMariner', 'Mariner', 'Windows2019', 'Windows2022'"
  type        = string
  validation {
    condition = contains(["Ubuntu", "CBLMariner", "Mariner", "Windows2019", "Windows2022"], var.worker_os_sku)
    error_message = "Accepted values are Ubuntu, CBLMariner, Mariner"
  }
}

variable "worker_pool_max_pods" {
  default     = 30
  description = "The default maximum number of pods to deploy per node when unspecified on a pool. Absolute maximum is 110."
  type        = number
  validation {
    condition     = var.worker_pool_max_pods > 0 && var.worker_pool_max_pods <= 110
    error_message = "Must be between 1 and 110."
  }
}

variable "worker_pool_orchestrator_version" {
  default     = null
  description = "Version of AKS orchestrator to use with this node pool"
  type        = string
}

variable "enable_auto_scaling" {
  default     = true
  description = "Whether this node pool should have autoscaling enabled"
  type        = bool
}

variable "os_disk_size_gb" {
  default     = null
  description = "Size of the os disk in GB"
  type        = number
}

