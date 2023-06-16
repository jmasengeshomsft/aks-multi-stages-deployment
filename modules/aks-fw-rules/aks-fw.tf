# Firewall Policy
resource "azurerm_firewall_policy" "aks" {
  name                = "AKSpolicy"
  resource_group_name = var.resource_group_name
  location            = var.location
  sku                 = var.fw_sku_tier
  contains(["Standard","Premium"], var.fw_sku_tier) ? dns { proxy_enabled = true } : ""
}

output "fw_policy_id" {
    value = azurerm_firewall_policy.aks.id
}

# Rules Collection Group
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
      protocols {
        type = "Http"
        port = 80 
      }
      source_addresses      = [var.aks_spoke_cidr]
      destination_fqdn_tags = ["AzureKubnernetesService"]
    }

    rule {
      name = "allow_network"
      protocols {
        type = "Https"
        port = 443
      }
      protocols {
        type = "Http"
        port = 80 
      }
      source_addresses      = ["*"]
      destination_fqdns = [
        "*.cdn.mscr.io",
        "*.hcp..azmk8s.io",
        "mcr.microsoft.com",
        "*.data.mcr.microsoft.com",
        "management.azure.com",
        "login.microsoftonline.com",
        "packages.microsoft.com",
        "acs-mirror.azureedge.net",
        "*.microsoftonline.com",
      ]
    }

    rule {
      name = "allow_monitoring"
      protocols {
        type = "Https"
        port = 443
      }
      protocols {
        type = "Http"
        port = 80 
      }
      source_addresses      = ["*"]
      destination_fqdns = [
        "dc.services.visualstudio.com",
        "*.ods.opinsights.azure.com",
        "*.oms.opinsights.azure.com",
        "*.monitoring.azure.com",
      ]
    }
    
    rule {
      name = "allow_github"
      protocols {
        type = "Https"
        port = 443
      }
      protocols {
        type = "Http"
        port = 80 
      }
      source_addresses      = ["*"]
      destination_fqdns = [
        "github.com",
        "api.github.com",
      ]
    }

    rule {
      name = "allow_policy"
      protocols {
        type = "Https"
        port = 443
      }
      protocols {
        type = "Http"
        port = 80 
      }
      source_addresses      = ["*"]
      destination_fqdns = [
        "data.policy.core.windows.net",
        "store.policy.core.windows.net",
      ]
    }

    rule {
      name = "allow_extensions"
      protocols {
        type = "Https"
        port = 443
      }
      protocols {
        type = "Http"
        port = 80 
      }
      source_addresses      = ["*"]
      destination_fqdns = [
        "*.dp.kubernetesconfiguration.azure.com",
        "arcmktplaceprod.azurecr.io",
        "*.ingestion.msftcloudes.com",
        "*.microsoftmetrics.com",
        "marketplaceapi.microsoft.com",
      ]
    }

    rule {
      name = "allow_gpu"
      protocols {
        type = "Https"
        port = 443
      }
      protocols {
        type = "Http"
        port = 80 
      }
      source_addresses      = ["*"]
      destination_fqdns = [
        "nvidia.github.io",
        "us.download.nvidia.com",
        "download.docker.com",
      ]
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
    rule {
      name                  = "servicetags"
      protocols             = ["Any"]
      source_addresses      = ["*"]
      destination_ports     = ["*"]
      destination_addresses = [
        "AzureContainerRegistry",
        "MicrosoftContainerRegistry",
        "AzureActiveDirectory"
      ]
    }
  }
}


