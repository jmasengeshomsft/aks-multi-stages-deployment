
resource "azurerm_kubernetes_cluster_node_pool" "aks_node_pool" {
    name                    = var.node_pool_name
    kubernetes_cluster_id   = var.cluster_id
    vm_size                 = var.vm_size
    max_pods                = var.max_pods_per_node
    vnet_subnet_id          = var.node_subnet_id
    pod_subnet_id           = var.pod_subnet_id
    enable_host_encryption  = var.enable_host_encryption
    enable_auto_scaling     = var.enable_auto_scaling
    enable_node_public_ip   = var.enable_node_public_ip
    mode                    = var.node_pool_mode
    os_type                 = var.os_type
    os_sku                  = var.os_sku
    min_count               = var.node_min_count
    max_count               = var.node_max_count
    zones                   = ["1","2","3"]
    tags                    = var.tags
    node_labels             = var.worker_node_labels
    node_taints             = var.worker_node_taints
  }
