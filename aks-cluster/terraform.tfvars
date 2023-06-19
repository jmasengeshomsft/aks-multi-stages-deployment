location = "eastus"
environment = "dev"
spoke_name  = "nvidia-dev"
//vnet
spoke_vnet_name = "vnet-spoke-nvidia-dev-001"
hub_resource_group_name = "nvidia-hub-rg"
spoke_resource_group_name = "nvidia-dev-rg"
hub_vnet_name = "vnet-hub-nvidia"
firewall_name = "nvidia-firewall001"
pod_subnet_name = "sn-pods"
aks_subnet_name = "sn-aks"
kubernetes_version = "1.26.3"

//acr
privatelink_subnet_name = "sn-plendpoints"

