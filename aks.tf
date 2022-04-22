resource "azurerm_kubernetes_cluster" "this" {
  name                = "grupo1-devops-aks"
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = "aks1"
  kubernetes_version  = "1.18.14"

  default_node_pool {
    name                = "default"
    node_count          = 1
    vm_size             = "Standard_D2_v2"
    vnet_subnet_id      = azurerm_subnet.this.id
    enable_auto_scaling = true
    max_count           = 2
    min_count           = 1
  }

  service_principal {
    client_id       = data.azurerm_key_vault_secret.client_id.value
    client_secret   = data.azurerm_key_vault_secret.client_secret.value
  }

  network_profile {
    network_plugin  = "azure"
    network_policy  = "azure"
  }
}