locals {
  dev_subnets = cidrsubnets(var.aks_spoke1_address_space, 5, 6)
  prod_subnets = cidrsubnets(var.aks_spoke2_address_space, 5, 6)
  //plendpoints_subnet2_address_space = cidrsubnets(var.aks_spoke2_address_space, 2, 2)
  private_dns_zones = [
      {
        name = "privatelink.azurecr.io"
      },
      {
        name = "privatelink.blob.core.windows.net"
      },
      {
        name = "privatelink.dfs.core.windows.net"
      },
      {
        name = "privatelink.vaultcore.azure.net"
      },
      {
        name = "privatelink.file.core.windows.net"
      },
      {
        name = "privatelink.web.core.windows.net"
      },
      {
        name = "privatelink.database.windows.net"
      },
      {
        name = "privatelink.documents.azure.com"
      },
      {
        name = "privatelink.${var.location}.azmk8s.io"
      },
      {
        name = "privatelink.mysql.database.azure.com"
      }
  ]
}

//dev spoke 1

 module "mfg-pg-dev-spoke" {
  source = "../modules/spoke-networking"
  hub_resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags
  spoke_name = "nvidia-dev-spoke1"
  spoke_address_space = var.aks_spoke1_address_space
  firewall_private_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  aks_subnet_address_space =  local.dev_subnets[0]     
  plendpoints_subnet_address_space = local.dev_subnets[1] 
  hub_vnet_name = "vnet-hub-${var.hub_prefix}"
  hub_vnet_id = azurerm_virtual_network.hub.id
  private_dns_zones = local.private_dns_zones
  # hub_prefix = var.hub_prefix
}


module "mfg-appinnovation-prod-spoke" {
  source = "../modules/spoke-networking"
  hub_resource_group_name = azurerm_resource_group.rg.name
  location = var.location
  tags = var.tags
  spoke_name = "nvidia-dev-spoke2"
  spoke_address_space = var.aks_spoke2_address_space
  firewall_private_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  aks_subnet_address_space =  local.prod_subnets[0]                    //var.aks_subnet2_address_space
  plendpoints_subnet_address_space = local.prod_subnets[1] 
  hub_vnet_name = "vnet-hub-${var.hub_prefix}"
  hub_vnet_id = azurerm_virtual_network.hub.id
  private_dns_zones = local.private_dns_zones
}

