
resource "azurerm_log_analytics_workspace" "spoke_law" {
  name                            = var.law_name
  location                        = var.default_location
  resource_group_name             = var.spoke_resource_group_name
  sku                             = "PerGB2018"
  retention_in_days               = 30
  allow_resource_only_permissions = true
  internet_ingestion_enabled      = true
  internet_query_enabled          = true
  tags                            = var.tags
}


module "key_vault" {
  source                      = "../key-vault/"
  key_vault_name              = var.key_vault_name
  location                    = var.default_location
  resource_group_name         = var.spoke_resource_group_name
  sku_name                    = var.key_vault_sku_name
  key_vault_subnet_id         = var.private_link_subnet_id
  tags                        = var.tags
} 

module "key_vault_dns_a_record" {
  source                     = "../private-dns-a-record/"
  resource_group_name        = var.hub_resource_group_name
  dns_zone_name              = var.key_vault_dns_zone_name
  dns_a_record_name          = module.key_vault.kv.name
  dns_name_ip_value          = module.key_vault.kv_private_link.private_service_connection[0].private_ip_address
  tags                       = var.tags
}

#container registry
module "container_registry" {
  source                     = "../acr/"
  resource_group_name        = var.spoke_resource_group_name
  location                   = var.default_location
  acr_name                   = var.acr_name
  acr_subnet_id              = var.private_link_subnet_id
  geo_replication_region     = var.geo_replication_region
  tags                       = var.tags
}

#storage account
module "storage_account" {
  source                      = "../storage-account/"
  storage_account_name        = var.storage_account_name
  location                    = var.default_location
  resource_group_name         = var.spoke_resource_group_name
  subnet_id                   = var.private_link_subnet_id
  tags                        = var.tags
} 

# data "azurerm_private_dns_zone" "file_share_dns_zone" {
#   name                = var.acr_dns_zone_name
#   resource_group_name = local.networking_rg
# }


module "storage_account_dns_a_record_file" {
  source                     = "../private-dns-a-record/"
  resource_group_name        = var.hub_resource_group_name
  dns_zone_name              = var.azure_file_dns_zone_name
  dns_a_record_name          = module.storage_account.storage.name
  dns_name_ip_value          = module.storage_account.storage_private_endpoint_file.private_service_connection[0].private_ip_address
  tags                       = var.tags
}
