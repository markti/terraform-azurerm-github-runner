
resource "azurerm_user_assigned_identity" "main" {
  location            = var.location
  resource_group_name = var.resource_group.name
  name                = "mi-${var.name}"
}

resource "azurerm_role_assignment" "keyvault_access" {
  scope                = var.keyvault_id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
}

resource "azurerm_role_assignment" "acr_pull" {
  scope                = var.container_registry_id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.main.principal_id
}