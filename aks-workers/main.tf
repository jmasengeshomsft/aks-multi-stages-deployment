locals {

}

module "worker_pool" {
  source                      = "../modules/aks-node-pools/"
  aks_cluster_resource_group  = var.aks_cluster_resource_group
  aks_cluster_name            = var.aks_cluster_name
} 

