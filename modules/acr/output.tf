output "private_acr_private_link" {
  value = azurerm_private_endpoint.container_registry_private_endpoint
}

output "private_acr" {
  value = azurerm_container_registry.acr
}