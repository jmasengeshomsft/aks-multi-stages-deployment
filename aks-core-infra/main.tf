data "azurerm_subnet" "private_link_subnet" {
  name                 = var.privatelink_subnet_name
  virtual_network_name = var.spoke_vnet_name
  resource_group_name  = var.spoke_resource_group_name
}

data "azurerm_resource_group" "spoke_rg" {
  name = var.spoke_resource_group_name
}

data "azurerm_private_dns_zone" "acr" {
  name                = var.acr_dns_zone_name
  resource_group_name = var.hub_resource_group_name
}

locals {
    storage_account_name = "${replace(var.spoke_name, "-", "")}strg001"
    acr_name                        = "${replace(var.spoke_name, "-", "")}acr001"
    key_vault_name                  = "${replace(var.spoke_name, "-", "")}kv001"
    law_name                        = "${var.spoke_name}-law001"
    location                        = data.azurerm_resource_group.spoke_rg.location
    spoke_resource_group_name       = data.azurerm_resource_group.spoke_rg.name
    private_link_subnet_id          = data.azurerm_subnet.private_link_subnet.id
}

resource "azurerm_log_analytics_workspace" "spoke_law" {
  name                            = local.law_name
  location                        = local.location
  resource_group_name             = local.spoke_resource_group_name
  sku                             = "PerGB2018"
  retention_in_days               = 30
  allow_resource_only_permissions = true
  internet_ingestion_enabled      = true
  internet_query_enabled          = true
  tags                            = var.tags
}

module "key_vault" {
  source                      = "../modules/key-vault/"
  key_vault_name              = local.key_vault_name
  location                    = local.location
  resource_group_name         = local.spoke_resource_group_name
  sku_name                    = var.key_vault_sku_name
  key_vault_subnet_id         = local.private_link_subnet_id
  tags                        = var.tags
} 

module "key_vault_dns_a_record" {
  source                     = "../modules/private-dns-a-record/"
  resource_group_name        = var.hub_resource_group_name
  dns_zone_name              = var.key_vault_dns_zone_name
  dns_a_record_name          = module.key_vault.kv.name
  dns_name_ip_value          = module.key_vault.kv_private_link.private_service_connection[0].private_ip_address
  tags                       = var.tags
}

#container registry
module "container_registry" {
  source                     = "../modules/acr/"
  resource_group_name        = local.spoke_resource_group_name
  location                   = local.location
  acr_name                   = local.acr_name
  acr_subnet_id              = local.private_link_subnet_id
  private_zone_id            = data.azurerm_private_dns_zone.acr.id
  //geo_replication_region     = var.geo_replication_region
  tags                       = var.tags
}

#storage account
module "storage_account" {
  source                      = "../modules/storage-account/"
  storage_account_name        = local.storage_account_name
  location                    = local.location
  resource_group_name         = local.spoke_resource_group_name
  subnet_id                   = local.private_link_subnet_id
  tags                        = var.tags
} 

module "storage_account_dns_a_record_file" {
  source                     = "../modules/private-dns-a-record/"
  resource_group_name        = var.hub_resource_group_name
  dns_zone_name              = var.azure_file_dns_zone_name
  dns_a_record_name          = module.storage_account.storage.name
  dns_name_ip_value          = module.storage_account.storage_private_endpoint_file.private_service_connection[0].private_ip_address
  tags                       = var.tags
}

module "storage_account_dns_a_record_blob" {
  source                     = "../modules/private-dns-a-record/"
  resource_group_name        = var.hub_resource_group_name
  dns_zone_name              = "privatelink.blob.core.windows.net"
  dns_a_record_name          = module.storage_account.storage.name
  dns_name_ip_value          = module.storage_account.storage_private_endpoint_blob.private_service_connection[0].private_ip_address
  tags                       = var.tags
}

module "application_insights" {
  source                      = "../modules/application-insights/"
  app_insights_name           = "${var.spoke_name}-ai001"
  location                    = local.location
  resource_group_name         = local.spoke_resource_group_name
  law_workspace_id            = azurerm_log_analytics_workspace.spoke_law.id
  tags                        = var.tags
}
