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
  source  = "../modules/spoke-networking"
  hub_resource_group_name           = azurerm_resource_group.rg.name
  location                          = var.location
  tags                              = var.tags
  spoke_name                        = "nvidia-dev"
  spoke_address_space               = var.aks_spoke1_address_space
  firewall_private_ip_address       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  aks_subnet_address_space          =  local.dev_subnets[0]                    //var.aks_subnet2_address_space
  plendpoints_subnet_address_space  = local.dev_subnets[1] 
  hub_vnet_name                     = "vnet-hub-${var.hub_prefix}"
  hub_vnet_id                       = azurerm_virtual_network.hub.id
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




# # Virtual Network for Hub
# # -----------------------

# resource "azurerm_virtual_network" "spoke" {
#   name                = "vnet-spoke-${var.hub_prefix}-dev-001"
#   resource_group_name = azurerm_resource_group.rg.name
#   location            = var.location
#   address_space       = [var.aks_spoke1_address_space]
#   dns_servers         = [azurerm_firewall.firewall.ip_configuration[0].private_ip_address]
#   tags                = var.tags

# }

# # SUBNETS on Hub Network
# # ----------------------

# # Firewall Subnet
# # (Additional subnet for Azure Firewall, without NSG as per Firewall requirements)
# resource "azurerm_subnet" "aks" {
#   name                                           = "sn-aks"
#   resource_group_name                            = azurerm_resource_group.rg.name
#   virtual_network_name                           = azurerm_virtual_network.spoke.name
#   address_prefixes                               = [var.aks_subnet_address_space]
#   private_endpoint_network_policies_enabled = false

# }

# # Gateway Subnet 
# # (Additional subnet for Gateway, without NSG as per requirements)
# resource "azurerm_subnet" "plendpoints" {
#   name                                           = "sn-plendpoints"
#   resource_group_name                            = azurerm_resource_group.rg.name
#   virtual_network_name                           = azurerm_virtual_network.spoke.name
#   address_prefixes                               = [var.plendpoints_subnet_address_space]
#   private_endpoint_network_policies_enabled = false

# }

# # Route Table
#  module "routes-spoke" {
#   source = "./modules/route-table"

#   resource_group_name  = azurerm_resource_group.rg.name
#   location             = azurerm_resource_group.rg.location
#   route_table_name     = "rt-aks"
#   virtual_appliance_ip = azurerm_firewall.firewall.ip_configuration[0].private_ip_address 
  
# }

# resource "azurerm_subnet_route_table_association" "aks-association" {
#   subnet_id      = azurerm_subnet.aks.id
#   route_table_id = module.routes-spoke.route_table.id
# }

