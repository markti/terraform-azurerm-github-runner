
resource "azapi_resource" "github_runner" {

  type      = "Microsoft.App/jobs@2023-05-01"
  name      = "caej-${var.name}"
  location  = var.location
  parent_id = var.resource_group.id
  identity {
    type = "UserAssigned"
    identity_ids = [
      azurerm_user_assigned_identity.main.id
    ]
  }
  body = jsonencode({
    properties = {
      configuration = {
        eventTriggerConfig = {
          parallelism            = 1
          replicaCompletionCount = 1
          scale = {
            maxExecutions   = 10
            minExecutions   = 0
            pollingInterval = 30
            rules = [
              {
                auth = [
                  {
                    secretRef        = "personal-access-token"
                    triggerParameter = "personalAccessToken"
                  }
                ]
                metadata = {
                  github-runner             = "https://api.github.com"
                  owner                     = var.github_owner
                  runnerScope               = "repo"
                  repos                     = var.github_repo
                  targetWorkflowQueueLength = "1"
                }
                name = "github-runner"
                type = "github-runner"
              }
            ]
          }
        }
        registries = [
          {
            identity = azurerm_user_assigned_identity.main.id
            server   = "${var.container_registry_endpoint}"
          }
        ]
        replicaRetryLimit = 0
        replicaTimeout    = 1800
        secrets = [
          {
            keyVaultUrl = "${var.key_vault_secret_uri}"
            identity    = azurerm_user_assigned_identity.main.id
            name        = "personal-access-token"
          }
        ]
        triggerType = "Event"
      }
      environmentId = azurerm_container_app_environment.main.id
      template = {
        containers = [
          {
            env = [
              {
                name      = "GITHUB_PAT"
                secretRef = "personal-access-token"
              },
              {
                name  = "REPO_URL"
                value = "https://github.com/${var.github_owner}/${var.github_repo}"
              },
              {
                name  = "REGISTRATION_TOKEN_API_URL"
                value = "https://api.github.com/repos/${var.github_owner}/${var.github_repo}/actions/runners/registration-token"
              }
            ]
            image = "${var.container_registry_endpoint}/${var.container_name}:${var.container_version}"
            name  = "gh-${var.name}"
            resources = {
              cpu    = var.cpu
              memory = var.memory
            }
          }
        ]
      }
    }
  })

}