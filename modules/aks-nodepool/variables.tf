
variable "cluster_resource_group_name" {
    description = "The name of the vnet"
}


variable "cluster_id" {
  default     = null
  description = "An existing AKS Cluster"
  type        = string
}

variable "worker_pool_size" {
  default     = 0
  description = "Default size for worker pools when unspecified on a pool. Required if auto-scaling is not enabled."
  type        = number
}

variable "node_min_count" {
    description = "Pool node count"
    default     = 3
}

variable "enable_auto_scaling" {
  default     = false
  description = "Enable auto-scaling for the node pool."
  type        = bool
}

variable "enable_host_encryption" {
  default     = false
  description = "Should the nodes in this Node Pool have host encryption enabled? Changing this forces a new resource to be created."
  type        = bool
}

variable "node_max_count" {
    description = "Pool node count"
    default     = 3
}

variable "enable_node_public_ip" {
  default     = false
  description = "Whether to provision workers with public IPs allocated by default when unspecified on a pool."
  type        = bool
}

variable "os_type" {
    description = "The Operating System which should be used for this Node Pool. Changing this forces a new resource to be created. Possible values are Linux and Windows. Defaults to Linux."
    default     = "Linux"
    type        = string
}

variable "os_sku" {
    description = "Specifies the OS SKU used by the agent pool. Possible values include: Ubuntu, CBLMariner, Mariner, Windows2019, Windows2022. If not specified, the default is Ubuntu if OSType=Linux or Windows2019 if OSType=Windows. And the default Windows OSSKU will be changed to Windows2022 after Windows2019 is deprecated. Changing this forces a new resource to be created"
    default     = "Ubuntu"
    type        = string
}


variable "node_subnet_id" {
    description = "The ID of the Subnet where this Node Pool should exist. Changing this forces a new resource to be created."
    default     = null
    type        = string
}

variable "pod_subnet_id" {
    description = "The ID of the Subnet where the pods in the Node Pool should exist. Changing this forces a new resource to be created."
    default     = null
    type        = string
}

variable "max_pods_per_node" {
  default     = 31
  description = "The default maximum number of pods to deploy per node when unspecified on a pool. Absolute maximum is 110. Ignored when when cni_type != 'npn'."
  type        = number

  validation {
    condition     = var.max_pods_per_node > 0 && var.max_pods_per_node <= 110
    error_message = "Must be between 1 and 110."
  }
}

variable "vm_size" {
    description = "VM Size"
    default     = "Standard_D2_v2"
}


variable "node_pool_type" {
    description = "VM type: AvailabilitySet or VirtualMachineScaleSets"
    default     = "VirtualMachineScaleSets"
}

variable "node_pool_mode" {
    description = "Should this Node Pool be used for System or User resources? Possible values are System and User. Defaults to User."
    default     = "User"
}

variable "worker_node_labels" {
  default     = {}
  description = "Default worker node labels. Merged with labels defined on each pool."
  type        = map(string)
}

variable "node_taints" {
  default     = {}
  description = " A list of Kubernetes taints which should be applied to nodes in the agent pool (e.g key=value:NoSchedule). Changing this forces a new resource to be created."
  type        = map(string)
}


variable "tags" {
  description = "A mapping of tags to assign to the resource."
  default     =  {}
  type        = map(string)
}
