resource "azurerm_route_table" "udr" {
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  disable_bgp_route_propagation = true
  tags = var.tags

    route {
        name                    = "Spoke_To_Firewall"
        address_prefix          = "0.0.0.0/0" #var.spoke_vnet_address_space
        next_hop_type           = "VirtualAppliance"
        next_hop_in_ip_address  = var.virtual_appliance_ip #data.azurerm_firewall.ip_configuration.private_ip_address
    }
}
