resource "azurerm_container_registry" "this" {
  name                = var.container_registry.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.container_registry.sku
  admin_enabled       = var.container_registry.admin_enabled
}