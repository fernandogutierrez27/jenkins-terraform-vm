data "azurerm_key_vault" "this" {
  name                = "diplomado-devops-akv"
  resource_group_name = "diplomado-devops-rg"
}

data "azurerm_key_vault_secret" "client_id" {
  name         = var.client_id_secret_name
  key_vault_id = data.azurerm_key_vault.this.id
}

data "azurerm_key_vault_secret" "client_secret" {
  name         = var.client_secret_secret_name
  key_vault_id = data.azurerm_key_vault.this.id
}