
data "azurerm_subnet" "pod_subnet" {
  name                 = var.pod_subnet_name
  virtual_network_name = var.spoke_vnet_name
  resource_group_name  = var.spoke_resource_group_name
}

data "azurerm_subnet" "node_subnet" {
  name                 = var.node_subnet_name
  virtual_network_name = var.spoke_vnet_name
  resource_group_name  = var.spoke_resource_group_name
}

module "worker_pool" {
  source                      = "../modules/aks-node-pools/"
  aks_cluster_resource_group  = var.aks_cluster_resource_group
  aks_cluster_name            = var.aks_cluster_name
  # pod_subnet_id               = data.azurerm_subnet.pod_subnet.id
  vnet_subnet_id              = data.azurerm_subnet.node_subnet.id
  worker_vm_sku               = var.worker_vm_sku
} 