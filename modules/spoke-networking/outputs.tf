output "spoke_vnet" {
  value = azurerm_virtual_network.spoke
}

output "plendpoints_subnet" {
  value = azurerm_subnet.plendpoints
}

