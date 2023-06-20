locals {
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

data "azurerm_firewall" "hub-firewall" {
  name                = "vnet-hub-${var.hub_prefix}-firewall"
  resource_group_name = var.hub_resource_group_name 
}

data "azurerm_virtual_network" "hub-vnet" {
  name                = var.hub_vnet_name 
  resource_group_name = var.hub_resource_group_name
}

//dev spoke 1
 module "dev-spoke" {
  source  = "../modules/spoke-networking"
  hub_resource_group_name           = var.hub_resource_group_name
  location                          = var.location
  tags                              = var.tags
  spoke_name                        = "${var.hub_prefix}-${var.environment}"
  spoke_address_space               = var.aks_spoke_address_space
  firewall_private_ip_address       = data.azurerm_firewall.hub-firewall.ip_configuration[0].private_ip_address
  enable_dns_from_firewall          = var.enable_dns_from_firewall
  node_subnet_address_space         = var.node_subnet_address_space 
  pod_subnet_address_space          = var.pod_subnet_address_space
  plendpoints_subnet_address_space  = var.plendpoints_subnet_address_space
  hub_vnet_name                     = var.hub_vnet_name 
  hub_vnet_id                       = data.azurerm_virtual_network.hub-vnet.id
  private_dns_zones                 = local.private_dns_zones
  # hub_prefix = var.hub_prefix
}


#  module "mfg-pg-dev-spoke_core_resources" {
#   source = "../modules/spoke-core-resources"
#   resource_group_name             = "mfg-pg-dev-rg"
#   default_location                = var.location
#   tags                            = var.tags
#   hub_vnet_name                   = "vnet-hub-${var.hub_prefix}"
#   spoke_vnet_name                 = module.mfg-pg-dev-spoke.spoke_vnet.name
#   hub_resource_group_name         = azurerm_resource_group.rg.name
#   private_link_subnet_id          = module.mfg-pg-dev-spoke.plendpoints_subnet.id
#   storage_account_name            = "mfgpgdevstrg001"
#   acr_name                        = "mfgpgdevacr001"
#   key_vault_name                  = "mfgpgdevkv001"
#   law_name                        = "mfg-pg-dev-law"
#   environment                     = "dev"

# }

//----------------------------------------------------------------------
# locals {
#   prod_subnets = cidrsubnets(var.aks_spoke2_address_space, 5, 6)
#   //plendpoints_subnet2_address_space = cidrsubnets(var.aks_spoke2_address_space, 2, 2)
# }

# module "mfg-appinnovation-prod-spoke" {
#   source = "../modules/spoke-networking"
#   hub_resource_group_name = azurerm_resource_group.rg.name
#   location = var.location
#   tags = var.tags
#   spoke_name = "nvidia-prod"
#   spoke_address_space = var.aks_spoke2_address_space
#   firewall_private_ip_address = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
#   aks_subnet_address_space =  local.prod_subnets[0]                    //var.aks_subnet2_address_space
#   plendpoints_subnet_address_space = local.prod_subnets[1] 
#   hub_vnet_name = "vnet-hub-${var.hub_prefix}"
#   hub_vnet_id = azurerm_virtual_network.hub.id
#   private_dns_zones = local.private_dns_zones
# }

