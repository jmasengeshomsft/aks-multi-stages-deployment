# Virtual Network for Hub
# -----------------------
module "core_resources_resource_group" {
  source                      = "../resource-group/"
  resource_group_name         = "${var.spoke_name}-rg"
  resource_group_location     = var.location
  tags                        = var.tags
} 

resource "azurerm_virtual_network" "spoke" {
  name                = "vnet-spoke-${var.spoke_name}-001"
  resource_group_name = module.core_resources_resource_group.rg.name
  location            = var.location
  address_space       = [var.spoke_address_space]
  tags                = var.tags
  dns_servers         = var.enable_dns_from_firewall == true ? [var.firewall_private_ip_address] : []

}

# SUBNETS on Hub Network
# ----------------------

# Firewall Subnet
# (Additional subnet for Azure Firewall, without NSG as per Firewall requirements)
# resource "azurerm_subnet" "aks" {
#   name                                      = "sn-aks"
#   resource_group_name                       = module.core_resources_resource_group.rg.name
#   virtual_network_name                      = azurerm_virtual_network.spoke.name
#   address_prefixes                          = [var.node_subnet_address_space]
#   private_endpoint_network_policies_enabled = true

# }

# # Pod Subnet
# resource "azurerm_subnet" "sn-pods" {
#   name                                      = "sn-pods"
#   resource_group_name                       = module.core_resources_resource_group.rg.name
#   virtual_network_name                      = azurerm_virtual_network.spoke.name
#   address_prefixes                          = [var.pod_subnet_address_space]
#   private_endpoint_network_policies_enabled = true 
#   delegation {
#     name = "delegation"

#     service_delegation {
#       name    = "Microsoft.ContainerService/managedClusters"
#       actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
#     }
#   }


# }

# Gateway Subnet 
# (Additional subnet for Gateway, without NSG as per requirements)
resource "azurerm_subnet" "plendpoints" {
  name                                      = "sn-plendpoints"
  resource_group_name                       = module.core_resources_resource_group.rg.name
  virtual_network_name                      = azurerm_virtual_network.spoke.name
  address_prefixes                          = [var.plendpoints_subnet_address_space]
  private_endpoint_network_policies_enabled = true 

}

# Route Table
 module "routes-spoke" {
  source = "../route-table"

  resource_group_name  = module.core_resources_resource_group.rg.name
  location             = var.location
  route_table_name     = "rt-aks"
  virtual_appliance_ip = var.firewall_private_ip_address   
}

#NSG
 module "default-spoke-nsg" {
  source              = "../nsg"
  nsg_name            = "${var.spoke_name}-default-nsg"
  location            = var.location
  resource_group_name = module.core_resources_resource_group.rg.name
}

resource "azurerm_subnet_network_security_group_association" "private_link_endpoints" {
  subnet_id                 = azurerm_subnet.plendpoints.id
  network_security_group_id = module.default-spoke-nsg.nsg.id
}

resource "azurerm_virtual_network_peering" "hub_to_spoke001" {
  name                      = "hub-${var.spoke_name}"
  resource_group_name       = module.core_resources_resource_group.rg.name
  virtual_network_name      = azurerm_virtual_network.spoke.name
  remote_virtual_network_id = var.hub_vnet_id
}

resource "azurerm_virtual_network_peering" "spoke001_to_hub" {
  name                      = "${var.spoke_name}-hub"
  resource_group_name       = var.hub_resource_group_name
  virtual_network_name      = var.hub_vnet_name
  remote_virtual_network_id = azurerm_virtual_network.spoke.id
}

//dns zone vnet linking
resource "azurerm_private_dns_zone_virtual_network_link" "link" {
  count =   length(var.private_dns_zones)
    name                  = azurerm_virtual_network.spoke.name
    resource_group_name   = var.hub_resource_group_name
    private_dns_zone_name = var.private_dns_zones[count.index].name
    virtual_network_id    = azurerm_virtual_network.spoke.id
    tags                  = var.tags
}
