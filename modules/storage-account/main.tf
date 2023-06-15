resource "azurerm_storage_account" "account" {
  name                            = var.storage_account_name
  resource_group_name             = var.resource_group_name
  location                        = var.location
  account_tier                    = "Standard"
  account_replication_type        = "GRS"
  account_kind                    = "StorageV2"
  # allow_nested_items_to_be_public = false
  # nfsv3_enabled                   = true
  # is_hns_enabled                  = true

  identity {
    type  = "SystemAssigned"
  }

  network_rules {
    default_action             = "Deny"
  }

  tags = var.tags
}

resource "azurerm_private_endpoint" "storage_private_endpoint_file" {
  name                = "${azurerm_storage_account.account.name}-file"       
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${azurerm_storage_account.account.name}-file"
    private_connection_resource_id = azurerm_storage_account.account.id
    is_manual_connection           = false
    subresource_names              = ["file"]
  }
}

resource "azurerm_private_endpoint" "storage_private_endpoint_blob" {
  name                = "${azurerm_storage_account.account.name}-blob" 
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${azurerm_storage_account.account.name}-blob"
    private_connection_resource_id = azurerm_storage_account.account.id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}