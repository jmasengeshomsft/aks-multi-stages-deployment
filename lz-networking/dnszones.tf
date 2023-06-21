module "zone_privatelink_blob" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.blob.core.windows.net"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}

module "zone_privatelink_file" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.file.core.windows.net"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}

module "zone_privatelink_acr" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.azurecr.io"
  virtual_network_id = azurerm_virtual_network.hub.id
}

module "zone_privatelink_web" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.web.core.windows.net"
  virtual_network_id = azurerm_virtual_network.hub.id 
}

module "zone_privatelink_dfs" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.dfs.core.windows.net"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}

module "zone_privatelink_sql" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.database.windows.net"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}

module "zone_privatelink_cosmos" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.documents.azure.com"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}

module "zone_privatelink_mysql" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.mysql.database.azure.com"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}

module "zone_privatelink_keyvault" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.vaultcore.azure.net"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}

module "zone_privatelink_k8s" {
  source = "../modules/private-dns-zone"

  resource_group_name = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.hub.name
  dns_zone_name = "privatelink.${var.location}.azmk8s.io"
  virtual_network_id = azurerm_virtual_network.hub.id
  
}