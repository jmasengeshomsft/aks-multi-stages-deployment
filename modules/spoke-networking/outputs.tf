output "spoke_vnet" {
  value = azurerm_virtual_network.spoke
}

output "spoke_resource_group_name" {
  value = module.core_resources_resource_group.rg.name
}

output "plendpoints_subnet" {
  value = azurerm_subnet.plendpoints
}

