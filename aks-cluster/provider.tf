provider "azurerm" {
  # # version = ">=3.0.0"
  features{
     resource_group {
      prevent_deletion_if_contains_resources = false
     }
  }
}

terraform {
  required_providers {
    azapi = {
      source = "azure/azapi"
    }
  }
}


# terraform {
#   backend "azurerm" {
#   }
# }

provider "azapi" {
  
}

terraform {
    required_version = ">= 0.12"
    }