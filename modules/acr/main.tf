
resource "azurerm_container_registry" "acr" {
  name                     = var.acr_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  sku                      = var.sku_name
  admin_enabled            = true
  data_endpoint_enabled    = true

  network_rule_set {
    default_action     = "Deny"
  }

  # georeplications {
  #   location                  = var.geo_replication_region
  #   zone_redundancy_enabled   = true
  #   regional_endpoint_enabled = true
  #   tags                      = var.tags
  # }

  tags                        = var.tags
}

resource "azurerm_private_endpoint" "container_registry_private_endpoint" {
  name                = azurerm_container_registry.acr.name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.acr_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = azurerm_container_registry.acr.name
    private_connection_resource_id = azurerm_container_registry.acr.id
    is_manual_connection           = false
    subresource_names              = ["registry"]
  }

   private_dns_zone_group {
    name = "acr-endpoint-zone"
    private_dns_zone_ids = [var.private_zone_id]
  }
}