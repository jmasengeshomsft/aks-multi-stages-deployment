resource "azurerm_application_insights" "app_insights" {
  name                = var.app_insights_name
  location            = var.location
  workspace_id        = var.law_workspace_id
  resource_group_name = var.resource_group_name
  application_type    = "other"
  tags                = var.tags
}