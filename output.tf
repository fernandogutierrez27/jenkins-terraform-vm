output "aks_id" {
  description = "Id del cluster de AKS"
  value       = azurerm_kubernetes_cluster.this.id
}
output "aks_fqdn" {
  description = "FQDN del cluster de AKS"
  value       = azurerm_kubernetes_cluster.this.fqdn
}

output "aks_portal_fqdn" {
  description = "FQDN del Portal del cluster de AKS"
  value       = azurerm_kubernetes_cluster.this.portal_fqdn
}

output "aks_private_fqdn" {
  description = "FQDN privafo del cluster de AKS"
  value       = azurerm_kubernetes_cluster.this.private_fqdn
}
output "aks_kunelet_identity" {
  description = "Identidad de AAD creada para kubelet"
  value       = azurerm_kubernetes_cluster.this.kubelet_identity
}