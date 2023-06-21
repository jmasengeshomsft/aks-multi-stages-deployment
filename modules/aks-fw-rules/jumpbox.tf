resource "azurerm_firewall_policy_rule_collection_group" "Jumpbox" {
  name               = "jumpbox-rcg"
  firewall_policy_id = azurerm_firewall_policy.aks.id
  priority           = 100
  application_rule_collection {
    name             = "jmp_app_rules"
    priority         = 105
    action           = "Allow"
    rule {
      protocols {
        type = "Https"
        port = 443
        
      }
      name = "jumpbox-https-allow"
      source_addresses      = [var.jumpbox_subnet_address_space]
      destination_fqdn_tags = ["AzureKubnernetesService"]
    }
    rule {
      protocols {
        type = "Http"
        port = 80
        
      }
      name = "jumpbox-http-allow"
      source_addresses      = [var.jumpbox_subnet_address_space]
      destination_fqdn_tags = ["AzureKubnernetesService"]
    }
  }

  network_rule_collection {
    name     = "jumpbox_network_rules"
    priority = 101
    action   = "Allow"
    rule {
      name                  = "dns"
      protocols             = ["UDP"]
      source_addresses      = [var.jumpbox_subnet_address_space]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }
    rule {
      name                  = "ntp"
      protocols             = ["UDP"]
      source_addresses      = [var.jumpbox_subnet_address_space]
      destination_addresses = ["*"]
      destination_ports     = ["123"]
    }
    rule {
      name                  = "ssh"
      protocols             = ["TCP"]
      source_addresses      = [var.jumpbox_subnet_address_space]
      destination_addresses = [var.aks_spoke_address_space]
      destination_ports     = ["22"]
    }
    rule {
      name                  = "http"
      protocols             = ["TCP"]
      source_addresses      = [var.jumpbox_subnet_address_space]
      destination_addresses = ["*"]
      destination_ports     = ["80"]
    }
    rule {
      name                  = "https"
      protocols             = ["TCP"]
      source_addresses      = [var.jumpbox_subnet_address_space]
      destination_addresses = ["*"]
      destination_ports     = ["443"]
    }
  }
}
