resource "azurerm_key_vault" "main" {
  name                          = "kv-${var.name}"
  location                      = azurerm_resource_group.main.location
  resource_group_name           = azurerm_resource_group.main.name
  tenant_id                     = data.azurerm_client_config.current.tenant_id
  sku_name                      = "standard"
  enable_rbac_authorization     = true
  public_network_access_enabled = true
  purge_protection_enabled      = false
}

resource "azurerm_role_assignment" "terraform_keyvault_access" {
  scope                = azurerm_key_vault.main.id
  role_definition_name = "Key Vault Administrator"
  principal_id         = data.azurerm_client_config.current.object_id
}

module "keyvault_monitor_diagnostic" {
  source  = "markti/azure-terraformer/azurerm//modules/monitor/diagnostic-setting/rando"
  version = "1.0.10"

  resource_id                = azurerm_key_vault.main.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.main.id
  logs                       = ["AuditEvent", "AzurePolicyEvaluationDetails"]

}

resource "azurerm_key_vault_secret" "github_token" {
  name         = "github-token"
  value        = var.github_token
  key_vault_id = azurerm_key_vault.main.id

  depends_on = [azurerm_role_assignment.terraform_keyvault_access]
}