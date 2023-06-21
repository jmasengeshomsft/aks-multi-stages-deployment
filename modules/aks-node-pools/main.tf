locals {
  node_taints = (var.worker_node_taints == "" || var.worker_node_taints == null) && var.worker_pool_mode == "System" ? ["CriticalAddonsOnly=true:NoSchedule"] : []
  pool_name   = coalesce(var.worker_pool_name, substr("wp${random_id.prefix.hex}", 0, 8))
}

resource "random_id" "prefix" {
  byte_length = 4
}

data "azurerm_kubernetes_cluster" "aks" {
  name                = var.aks_cluster_name
  resource_group_name = var.aks_cluster_resource_group
}

resource "azurerm_kubernetes_cluster_node_pool" "modpool" {
  kubernetes_cluster_id           = data.azurerm_kubernetes_cluster.aks.id
  mode                            = var.worker_pool_mode
  name                            = local.pool_name 
  orchestrator_version            = var.worker_pool_orchestrator_version
  node_count                      = var.worker_pool_size
  vm_size                         = var.worker_vm_sku
  host_group_id                   = var.host_group_id
  tags                            = var.tags
  max_pods                        = var.worker_pool_max_pods 
  os_disk_size_gb                 = var.os_disk_size_gb
  os_type                         = var.worker_os_type
  os_sku                          = var.worker_os_sku
  node_taints                     = local.node_taints
  enable_auto_scaling             = var.enable_auto_scaling
  min_count                       = var.worker_pool_min_count
  max_count                       = var.worker_pool_max_count
  priority                        = var.worker_pool_node_priority
  enable_node_public_ip           = var.enable_node_public_ip
  pod_subnet_id                   = var.pod_subnet_id
  vnet_subnet_id                  = var.vnet_subnet_id

  lifecycle {
    precondition {
      condition     = (var.worker_os_type == "Linux") ? contains(["Ubuntu", "CBLMariner", "Mariner"], var.worker_os_sku) : contains(["Windows2019", "Windows2022"])
      error_message = "Must use a Linux OS when worker_os_type is set to Linux"
    }
    precondition {
      condition     = var.worker_pool_min_count <= var.worker_pool_max_count
      error_message = "Min count must be less than or equal to the max node count"
    }
  }
}
