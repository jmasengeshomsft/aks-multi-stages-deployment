
resource "azurerm_network_security_group" "nsg" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
  security_rule = [
    for rule in var.nsg_rules: {
        name                                        = rule.name
        priority                                    = rule.priority
        direction                                   = rule.direction
        access                                      = rule.access
        protocol                                    = rule.protocol
        source_port_range                           = rule.source_port_range
        destination_port_range                      = rule.destination_port_range
        source_address_prefix                       = rule.source_address_prefix
        destination_address_prefix                  = rule.destination_address_prefix
        description                                 = rule.description
        destination_address_prefixes                = rule.destination_address_prefixes
        destination_application_security_group_ids  = rule.destination_application_security_group_ids
        destination_port_ranges                     = rule.destination_port_ranges
        source_address_prefixes                     = rule.source_address_prefixes
        source_application_security_group_ids       = rule.source_application_security_group_ids
        source_port_ranges                          = rule.source_port_ranges
    }
  ]
}