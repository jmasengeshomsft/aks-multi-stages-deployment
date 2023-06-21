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



//dev spoke 1
 module "mfg-pg-dev-spoke" {
  source  = "../modules/spoke-networking"
  hub_resource_group_name           = azurerm_resource_group.rg.name
  location                          = var.location
  tags                              = var.tags
  spoke_name                        = var.default_spoke_name
  spoke_address_space               = var.aks_spoke_address_space
  firewall_private_ip_address       = azurerm_firewall.firewall.ip_configuration[0].private_ip_address
  enable_dns_from_firewall          = var.enable_dns_from_firewall
  plendpoints_subnet_address_space  = var.plendpoints_subnet_address_space
  hub_vnet_name                     = "vnet-hub-${var.hub_prefix}"
  hub_vnet_id                       = azurerm_virtual_network.hub.id
  private_dns_zones                 = local.private_dns_zones
  # hub_prefix = var.hub_prefix
}
