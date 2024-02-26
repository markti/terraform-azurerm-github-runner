output "managed_id" {
  value = azurerm_user_assigned_identity.main.id
}
output "container_app_job_id" {
  value = azapi_resource.github_runner.id
}