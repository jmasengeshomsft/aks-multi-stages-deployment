# Firewall Policy

variable "resource_group_name" {}

variable "location" {}

variable "aks_spoke_cidr" {}

variable jumpbox_subnet_address_space {}

resource "azurerm_firewall_policy" "aks" {
  name                = "AKSpolicy"
  resource_group_name = var.resource_group_name
  location            = var.location
  dns {
    proxy_enabled     = true
  }
}

output "fw_policy_id" {
    value = azurerm_firewall_policy.aks.id
}

# Rules Collection Group

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
      destination_addresses = [var.aks_spoke_cidr]
      destination_ports     = ["22"]
    }

  }
}

resource "azurerm_firewall_policy_rule_collection_group" "AKS" {
  name               = "aks-rcg"
  firewall_policy_id = azurerm_firewall_policy.aks.id
  priority           = 200
  application_rule_collection {
    name     = "aks_app_rules"
    priority = 205
    action   = "Allow"
    rule {
      name = "aks_service"
      protocols {
        type = "Https"
        port = 443
      }
      source_addresses      = [var.aks_spoke_cidr]
      destination_fqdn_tags = ["AzureKubnernetesService"]
    }
  }

  network_rule_collection {
    name     = "aks_network_rules"
    priority = 201
    action   = "Allow"
    rule {
      name                  = "https"
      protocols             = ["TCP"]
      source_addresses      = [var.aks_spoke_cidr]
      destination_addresses = ["*"]
      destination_ports     = ["443"]
    }
    rule {
      name                  = "dns"
      protocols             = ["UDP"]
      source_addresses      = [var.aks_spoke_cidr]
      destination_addresses = ["*"]
      destination_ports     = ["53"]
    }
    rule {
      name                  = "time"
      protocols             = ["UDP"]
      source_addresses      = [var.aks_spoke_cidr]
      destination_addresses = ["*"]
      destination_ports     = ["123"]
    }
    rule {
      name                  = "tunnel_udp"
      protocols             = ["UDP"]
      source_addresses      = [var.aks_spoke_cidr]
      destination_addresses = ["*"]
      destination_ports     = ["1194"]
    }
    rule {
      name                  = "tunnel_tcp"
      protocols             = ["TCP"]
      source_addresses      = [var.aks_spoke_cidr]
      destination_addresses = ["*"]
      destination_ports     = ["9000"]
    }
  }

}


