# Virtual Network for Hub
# -----------------------

resource "azurerm_virtual_network" "hub" {
  name                = "vnet-hub-${var.hub_prefix}"
  resource_group_name = azurerm_resource_group.rg.name
  location            = var.location
  address_space       = [var.hub_address_space]
  dns_servers         = null
  tags                = var.tags

}

# SUBNETS on Hub Network
# ----------------------

# Firewall Subnet
# (Additional subnet for Azure Firewall, without NSG as per Firewall requirements)
resource "azurerm_subnet" "firewall" {
  name                                           = "AzureFirewallSubnet"
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.hub.name
  address_prefixes                               = [var.firewall_subnet_address_space]
  private_endpoint_network_policies_enabled      = false 
}

resource "azurerm_subnet" "mgmt_firewall" {
  name                                           = "AzureFirewallManagementSubnet"
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.hub.name
  address_prefixes                               = [var.mgmt_firewall_subnet_address_space]
  private_endpoint_network_policies_enabled      = false 
}

resource "azurerm_subnet" "jumbpox" {
  name                                           = "sn-jumpbox"
  resource_group_name                            = azurerm_resource_group.rg.name
  virtual_network_name                           = azurerm_virtual_network.hub.name
  address_prefixes                               = [var.jumpbox_subnet_address_space]
  private_endpoint_network_policies_enabled      = false 
  
}

# Route Table
 module "routes" {
  source = "../modules/route-table"

  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  route_table_name     = "rt-${var.hub_prefix}"
  virtual_appliance_ip = azurerm_firewall.firewall.ip_configuration[0].private_ip_address 
  
}

resource "azurerm_subnet_route_table_association" "jumpbox-association" {
  subnet_id      = azurerm_subnet.jumbpox.id
  route_table_id = module.routes.route_table.id
}

#############
## OUTPUTS ##
#############
# These outputs are used by later deployments

output "hub_vnet_name" {
  value = azurerm_virtual_network.hub.name
}

output "hub_vnet_id" {
  value = azurerm_virtual_network.hub.id
}
