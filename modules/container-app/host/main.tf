resource "azurerm_resource_group" "main" {
  name     = "rg-${var.name}"
  location = var.location
}