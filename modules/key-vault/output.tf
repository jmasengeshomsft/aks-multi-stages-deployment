output "kv" {
  value = azurerm_key_vault.key_vault
}

output "kv_private_link" {
  value = azurerm_private_endpoint.key_vault_private_endpoint
}