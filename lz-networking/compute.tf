module "virtual_machine" {
  source = "../modules/virtual-machine"

  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  virtual_network_name = azurerm_virtual_network.hub.name
  vm_subnet_id = azurerm_subnet.jumbpox.id
  vm_name = "vm-${var.hub_prefix}"
  admin_password = var.admin_password
}

# Bastion - Module creates additional subnet (without NSG), public IP and Bastion
module "bastion" {
  source = "../modules/bastion"

  subnet_cidr          = var.bastion_subnet_address_space
  virtual_network_name = azurerm_virtual_network.hub.name
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location

}
