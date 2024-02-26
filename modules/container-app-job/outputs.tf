output "managed_id" {
  value = azurerm_container_app_job.main.id
}
output "container_app_job_id" {
  value = azapi_resource.github_runner.id
}