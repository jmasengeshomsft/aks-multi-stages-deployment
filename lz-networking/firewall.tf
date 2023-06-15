# Azure Firewall 
# --------------
# Firewall Rules created via Module

resource "azurerm_firewall" "firewall" {
  name                = "${azurerm_virtual_network.hub.name}-firewall"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  firewall_policy_id  = module.firewall_rules_aks.fw_policy_id
  sku_name            = var.sku_name
  sku_tier            = var.sku_tier

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }
}

resource "azurerm_public_ip" "firewall" {
  name                 = "${azurerm_virtual_network.hub.name}-firewall-pip"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  allocation_method    = "Static"
  sku                  = "Standard"
}

module "firewall_rules_aks" {
  source = "../modules/aks-fw-rules"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  aks_spoke_cidr      = var.aks_spoke_cidr
  jumpbox_subnet_address_space = var.jumpbox_subnet_address_space
}