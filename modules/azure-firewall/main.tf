# resource "azurerm_subnet" "firewall_subnet" {
#   name                 = "AzureFirewallSubnet"
#   resource_group_name  = var.resource_group_name
#   virtual_network_name = var.virtual_network_name
#   address_prefixes     = var.firewall_subnet_address_space
# }

resource "azurerm_public_ip" "firewall_ip" {
  name                = "azure_firewall_ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_firewall" "firewall" {
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.firewall_subnet_id
    public_ip_address_id = azurerm_public_ip.firewall_ip.id
  }
}
