
resource "random_string" "main" {
  length  = 8
  upper   = false
  special = false
}


module "host" {
  source = "../../modules/container-app/host"

  name          = random_string.main.result
  location      = "westus3"
  address_space = "10.16.0.0/22"
  github_token  = var.github_token

}

module "job" {
  source = "../../modules/container-app/job"

  name                         = random_string.main.result
  location                     = module.host.location
  resource_group               = module.host.resource_group
  github_owner                 = var.github_owner
  github_repo                  = var.github_repo
  container_app_environment_id = module.host.container_app_environment_id
  container_registry_id        = module.host.container_registry.id
  container_registry_endpoint  = module.host.container_registry.endpoint
  container_name               = module.host.container_name
  container_version            = "latest"
  keyvault_id                  = module.host.keyvault_id
  key_vault_secret_uri         = module.host.key_vault_secret_uri

}