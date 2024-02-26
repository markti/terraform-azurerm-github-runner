variable "name" {
  type = string
}
variable "location" {
  type = string
}
variable "github_token" {
  type = string
}
variable "address_space" {
  type = string
}
variable "container_name" {
  type    = string
  default = "github-runner"
}