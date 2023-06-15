
resource "azurerm_private_dns_a_record" "a_record" {
  name                = var.dns_a_record_name
  zone_name           = var.dns_zone_name
  resource_group_name = var.resource_group_name
  ttl                 = 3600
  records             = [var.dns_name_ip_value]
  tags                = var.tags
}

