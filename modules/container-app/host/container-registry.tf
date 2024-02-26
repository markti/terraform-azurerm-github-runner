resource "azurerm_container_registry" "main" {

  name                          = "cr${var.name}"
  resource_group_name           = azurerm_resource_group.main.name
  location                      = azurerm_resource_group.main.location
  sku                           = "Premium"
  zone_redundancy_enabled       = true
  admin_enabled                 = true
  public_network_access_enabled = true

}

resource "azurerm_role_assignment" "github_runner_acr_pull" {
  scope                = azurerm_container_registry.main.id
  role_definition_name = "AcrPull"
  principal_id         = azurerm_user_assigned_identity.github_runner.principal_id
}