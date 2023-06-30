
module "dev_cluster_networking" {
  source                                 = "../modules/cluster-networking/"
  spoke_vnet_name                        = var.spoke_vnet_name
  spoke_resource_group_name              = var.spoke_resource_group_name
  # pod_subnet_name                        = "${var.aks_cluster_name}-pod-subnet"
  # pods_nsg_name                          = "${var.aks_cluster_name}-pods-nsg"
  # pod_subnet_address_space               = var.pod_subnet_address_space
  aks_subnet_name                        = "${var.aks_cluster_name}-node-subnet"
  nodes_nsg_name                          = "${var.aks_cluster_name}-nodes-nsg"
  node_subnet_address_space              = var.node_subnet_address_space
  route_table_name                       = var.route_table_name
  tags                                   = var.tags
}
