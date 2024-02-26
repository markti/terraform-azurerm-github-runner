variable "name" {
  type = string
}
variable "resource_group" {
  type = object({
    id   = string
    name = string
  })
}
variable "location" {
  type = string
}
variable "github_owner" {
  type = string
}
variable "github_repo" {
  type = string
}
variable "container_app_environment_id" {
  type = string
}
variable "container_registry_id" {
  type = string
}
variable "container_registry_endpoint" {
  type = string
  validation {
    condition     = can(regex(".*azurecr\\.io.*", var.container_registry_endpoint))
    error_message = "The container registry endpoint must contain 'azurecr.io'."
  }
}
variable "container_name" {
  type = string
}
variable "container_version" {
  type = string
}
variable "cpu" {
  type    = number
  default = 2
}
variable "memory" {
  type    = string
  default = "4Gi"
}
variable "keyvault_id" {
  type = string
}
variable "key_vault_secret_uri" {
  type = string
}