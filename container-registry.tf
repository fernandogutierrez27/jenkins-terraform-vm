resource "azurerm_container_registry" "this" {
  name                = var.container_registry.name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  sku                 = var.container_registry.sku
  admin_enabled       = var.container_registry.admin_enabled
}

resource "azurerm_key_vault_secret" "acr_admin_username" {
  name         = "acr-admin-username"
  value        = azurerm_container_registry.this.admin_username
  key_vault_id = data.azurerm_key_vault.this.id
}

resource "azurerm_key_vault_secret" "acr_admin_password" {
  name         = "acr-admin-password"
  value        = azurerm_container_registry.this.admin_password
  key_vault_id = data.azurerm_key_vault.this.id
}

