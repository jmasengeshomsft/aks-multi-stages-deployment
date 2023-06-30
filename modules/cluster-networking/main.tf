# Virtual Network for the Spoke
# -----------------------
data "azurerm_resource_group" "spoke_rg" {
  name = var.spoke_resource_group_name
}

data "azurerm_virtual_network" "spoke_vnet" {
  name                = var.spoke_vnet_name
  resource_group_name = var.spoke_resource_group_name
}

# AKS Subnet
resource "azurerm_subnet" "aks" {
  name                                      = var.aks_subnet_name
  resource_group_name                       = data.azurerm_resource_group.spoke_rg.name
  virtual_network_name                      = data.azurerm_virtual_network.spoke_vnet.name
  address_prefixes                          = [var.node_subnet_address_space]
  # private_endpoint_network_policies_enabled = true
}

# Pod Subnet
# resource "azurerm_subnet" "sn-pods" {
#   name                                      = var.pod_subnet_name
#   resource_group_name                       = data.azurerm_resource_group.spoke_rg.name
#   virtual_network_name                      = data.azurerm_virtual_network.spoke_vnet.name
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

# Route Table
data "azurerm_route_table" "aks_rt" {
  name                = var.route_table_name
  resource_group_name = var.spoke_resource_group_name
}

resource "azurerm_subnet_route_table_association" "aks-association" {
  subnet_id      = azurerm_subnet.aks.id
  route_table_id = data.azurerm_route_table.aks_rt.id
}

#Nodes NSG
 module "nodes-nsg" {
  source              = "../nsg"
  nsg_name            = var.nodes_nsg_name
  location            = data.azurerm_resource_group.spoke_rg.location
  resource_group_name = var.spoke_resource_group_name
}

resource "azurerm_subnet_network_security_group_association" "nodes_nsg_association" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = module.nodes-nsg.nsg.id
}

#Pods NSG
#  module "pods-nsg" {
#   source              = "../nsg"
#   nsg_name            = var.pods_nsg_name
#   location            = data.azurerm_resource_group.spoke_rg.location
#   resource_group_name = var.spoke_resource_group_name
# }

# resource "azurerm_subnet_network_security_group_association" "pods_nsg_association" {
#   subnet_id                 = azurerm_subnet.sn-pods.id
#   network_security_group_id = module.nodes-nsg.nsg.id
# }