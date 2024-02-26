output "container_name" {
  value      = var.container_name
  depends_on = [null_resource.build_container_image]
}
output "location" {
  value = azurerm_resource_group.main.location
}
output "resource_group" {
  value = {
    id   = azurerm_resource_group.main.id
    name = azurerm_resource_group.main.name
  }
}
output "container_registry" {
  value = {
    id       = azurerm_container_registry.main.id
    name     = azurerm_container_registry.main.name
    endpoint = azurerm_container_registry.main.login_server
  }
}
output "keyvault_id" {
  value = azurerm_key_vault.main.id
}
output "key_vault_secret_uri" {
  value = azurerm_key_vault_secret.github_token.id
}
output "container_app_environment_id" {
  value = azurerm_container_app_environment.main.id
}