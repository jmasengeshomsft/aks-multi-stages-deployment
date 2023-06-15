
# location = "eastus"
environment = "dev"
spoke_name  = "mfg-pg-dev"
//vnet
# spoke_vnet_name = "vnet-spoke-mfg-pg-dev-001"
hub_resource_group_name = "aks-playg-hub"
# spoke_resource_group_name = "mfg-pg-dev-rg"
hub_vnet_name = "vnet-hub-aks-playg"
firewall_name = "demo-firewall001"
aks_subnet_name = "sn-aks"
# aks_cluster_name = "mfg-pg-dev-cluster001"
kubernetes_version = "1.24.3"

//acr
privatelink_subnet_name = "sn-plendpoints"

