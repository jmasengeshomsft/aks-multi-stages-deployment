# Azure Firewall 
# --------------
# Firewall Rules created via Module

resource "azurerm_firewall" "firewall" {
  name                = "${azurerm_virtual_network.hub.name}-firewall"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  sku_name            = var.fw_sku_name
  sku_tier            = var.fw_sku
  firewall_policy_id  = module.firewall_rules_aks.fw_policy_id

  ip_configuration {
    name                 = "fw_ip_configuration"
    subnet_id            = azurerm_subnet.firewall.id
    public_ip_address_id = azurerm_public_ip.firewall.id
  }

  management_ip_configuration {
    name                 = "fw_mgmt_ip_configuration"
    subnet_id            = azurerm_subnet.mgmt_firewall.id
    public_ip_address_id = azurerm_public_ip.mgmt_firewall.id
  }
}

resource "azurerm_public_ip" "firewall" {
  name                 = "${azurerm_virtual_network.hub.name}-firewall-pip"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  allocation_method    = "Static"
  sku                  = "Standard"
}

resource "azurerm_public_ip" "mgmt_firewall" {
  name                 = "${azurerm_virtual_network.hub.name}-mgmt_firewall-pip"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  allocation_method    = "Static"
  sku                  = "Standard"
}

module "firewall_rules_aks" {
  source = "../modules/aks-fw-rules"

  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  aks_spoke_address_space       = var.aks_spoke_address_space
  jumpbox_subnet_address_space  = var.jumpbox_subnet_address_space
  fw_policy_sku                 = var.fw_policy_sku
}
