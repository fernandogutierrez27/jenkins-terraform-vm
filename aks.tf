resource "azurerm_kubernetes_cluster" "this" {
  name                = var.kubernetes_cluster.name
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  dns_prefix          = var.kubernetes_cluster.dns_prefix
#   kubernetes_version  = "1.18.14"

  default_node_pool {
    name                = var.kubernetes_cluster.default_node_pool.name
    node_count          = var.kubernetes_cluster.default_node_pool.node_count
    vm_size             = var.kubernetes_cluster.default_node_pool.vm_size
    vnet_subnet_id      = azurerm_subnet.this.id
    enable_auto_scaling = var.kubernetes_cluster.default_node_pool.enable_auto_scaling
    max_count           = var.kubernetes_cluster.default_node_pool.max_count
    min_count           = var.kubernetes_cluster.default_node_pool.min_count
  }

  service_principal {
    client_id       = data.azurerm_key_vault_secret.client_id.value
    client_secret   = data.azurerm_key_vault_secret.client_secret.value
  }

  network_profile {
    network_plugin  = var.kubernetes_cluster.network_plugin
    network_policy  = var.kubernetes_cluster.network_policy
  }
}