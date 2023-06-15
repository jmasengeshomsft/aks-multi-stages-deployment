data "azurerm_client_config" "current" {}

locals {
   hub_vnet                   = var.hub_vnet_name
   spoke_vnet                 = var.spoke_vnet_name
   storage_account_name       = "${replace(var.spoke_name, "-", "")}strg001"
   acr_name                   = "${replace(var.spoke_name, "-", "")}acr001"
   key_vault_name             = "${replace(var.spoke_name, "-", "")}kv001"
   workspace_name             = "${var.spoke_name}-law001"
   aks_cluster_name           = "${var.spoke_name}-aks001"
   spoke_resources_rg         = data.azurerm_resource_group.spoke_rg.name
}

data "azurerm_resource_group" "spoke_rg" {
  name = var.spoke_resource_group_name
}

data "azurerm_virtual_network" "spoke_vnet" {
  name                = var.spoke_vnet_name
  resource_group_name = var.spoke_resource_group_name
}

data "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  resource_group_name = var.hub_resource_group_name
}

data "azurerm_subnet" "aks_subnet" {
  name                 = var.aks_subnet_name
  virtual_network_name = var.spoke_vnet_name
  resource_group_name  = var.spoke_resource_group_name
}

data "azurerm_subnet" "private_link_subnet" {
  name                 = var.privatelink_subnet_name
  virtual_network_name = var.spoke_vnet_name
  resource_group_name  = var.spoke_resource_group_name
}

data "azurerm_container_registry" "acr" {
  name                = local.acr_name
  resource_group_name = var.spoke_resource_group_name
}

data "azurerm_storage_account" "aks_file_share" {
  name                = local.storage_account_name
  resource_group_name = var.spoke_resource_group_name
}

//To be created
data "azurerm_log_analytics_workspace" "logs" {
  name                = local.workspace_name
  resource_group_name = var.spoke_resource_group_name
}

# Deploy OPA policies
# resource "azurerm_subscription_template_deployment" "azure_policy" {
#   name                = "${var.spoke_resource_group_name}_AKS_Azure_Policies"
#   location            = var.location
#   template_content    = file("./opa-policy/aks_initiatives_template.json")
#   tags               = var.tags
# }

# data "azurerm_policy_set_definition" "aks_definition" {
#   display_name = "Enterprise Scale AKS - Azure Policy Initiative"
# }

# resource "azurerm_resource_group_policy_assignment" "aks_policy_assignment" {
#    depends_on = [
#     azurerm_subscription_template_deployment.azure_policy
#   ]
#   location = var.location
#   name                 = "AKS-EnterpriseScale-Initiative-Assignment"
#   resource_group_id    = data.azurerm_resource_group.spoke_rg.id
#   policy_definition_id = data.azurerm_policy_set_definition.aks_definition.id

#   identity {
#     type = "SystemAssigned"
#   }
#   enforce               = false
# }


module "azurerm_aks_cluster" {
  depends_on = [
    #  azurerm_resource_group_policy_assignment.aks_policy_assignment
    # azurerm_firewall_network_rule_collection.aks_network_rule,
    # azurerm_subnet_network_security_group_association.aks_nsg_association,
    # azurerm_subnet_route_table_association.aks_udr_association
  ]
  source                                 = "../modules/aks-cluster/"
  resource_group_name                    = data.azurerm_resource_group.spoke_rg.name
  location                               = var.location
  virtual_network_name                   = data.azurerm_virtual_network.spoke_vnet.name 
  vnet_resource_group_name               = var.spoke_resource_group_name
  aks_subnet_id                          = data.azurerm_subnet.aks_subnet.id
  default_pool_max_pods                  = var.default_pool_max_pods
  tenant_id                              = var.aad_tenant_id
  azure_aad_admin_group_id               = var.azure_aad_admin_group_id
  linux_admin_user                       = var.linux_admin_user 
  aks_cluster_name                       = local.aks_cluster_name
  kubernetes_version                     = "1.25.6"     #var.kubernetes_version 
  default_node_count                     = var.default_node_count 
  azurerm_log_analytics_workspace_id     = data.azurerm_log_analytics_workspace.logs.id
  default_vm_size                        = var.default_vm_size
  node_pool_type                         = var.node_pool_type 
  network_policy                         = var.network_policy
  network_plugin                         = var.network_plugin 
  network_plugin_mode                    = var.network_plugin_mode 
  ebpf_data_plane                        = var.ebpf_data_plane   
  pod_cidr                               = var.pod_cidr 
  # docker_bridge_cidr                     = var.docker_bridge_cidr 
  service_cidr                           = var.service_cidr 
  dns_service_ip                         = var.dns_service_ip
  outbound_type                          = "userDefinedRouting"
  # user_assigned_identity                 = azurerm_user_assigned_identity.aks_user_identity.principal_id
  # private_dns_zone_id                    = data.azurerm_private_dns_zone.aks_zone.id
  tags                                   = var.tags
}


resource "azurerm_role_assignment" "AcrPull" {
  principal_id                     = module.azurerm_aks_cluster.cluster.kubelet_identity[0].object_id
  role_definition_name             = "AcrPull"
  scope                            = data.azurerm_container_registry.acr.id
  skip_service_principal_aad_check = true
}


data "azurerm_key_vault" "key_vault" {
  name                = local.key_vault_name
  resource_group_name = var.spoke_resource_group_name
}

resource "azurerm_role_assignment" "aks_volume_read" {
  principal_id                     = module.azurerm_aks_cluster.cluster.identity[0].principal_id
  role_definition_name             = "Contributor"
  scope                            = data.azurerm_storage_account.aks_file_share.id
  skip_service_principal_aad_check = true
}

resource "azurerm_role_assignment" "aks_RBAC_csi_cert" {
  principal_id                     = module.azurerm_aks_cluster.cluster.key_vault_secrets_provider[0].secret_identity[0].object_id
  role_definition_name             = "Key Vault Secrets Officer"
  scope                            = data.azurerm_key_vault.key_vault.id
  skip_service_principal_aad_check = true
}

#enable the cluster to create loadbalancers in the vnet
resource "azurerm_role_assignment" "AKS_Vnet_Join" {
  principal_id                     = module.azurerm_aks_cluster.cluster.identity[0].principal_id
  role_definition_name             = "Owner"
  scope                            = data.azurerm_virtual_network.spoke_vnet.id
  skip_service_principal_aad_check = true
}
