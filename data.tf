data "azurerm_key_vault" "this" {
  name                = var.akv_name
  resource_group_name = var.akv_resource_group
}

data "azurerm_key_vault_secret" "client_id" {
  name         = var.client_id_secret_name
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "client_secret" {
  name         = var.client_secret_secret_name
  key_vault_id = data.azurerm_key_vault.this.id
}