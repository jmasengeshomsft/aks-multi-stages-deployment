location = "eastus"
environment = "dev"
spoke_name  = "ebm-private-devel"
//vnet
spoke_vnet_name = "vnet-spoke-ebm-private-dev-001"
hub_resource_group_name = "ebm-private-hub-rg"
spoke_resource_group_name = "ebm-private-dev-rg"
hub_vnet_name = "vnet-hub-ebm-private"
firewall_name = "vnet-hub-ebm-private-firewall"
pod_subnet_name = "sn-pods"
aks_subnet_name = "sn-aks"
kubernetes_version = "1.27.1"

//acr
privatelink_subnet_name = "sn-plendpoints"

