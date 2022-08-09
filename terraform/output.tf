output "aks_id" {
  value = azurerm_kubernetes_cluster.mlsc-aks.id
}

output "aks_fqdn" {
  value = azurerm_kubernetes_cluster.mlsc-aks.fqdn
}

output "aks_node_rg" {
  value = azurerm_kubernetes_cluster.mlsc-aks.node_resource_group
}

output "acr_id" {
  value = azurerm_container_registry.mlsc-cg.id
}

output "acr_login_server" {
  value = azurerm_container_registry.mlsc-cg.login_server
}

resource "local_file" "kubeconfig" {
  depends_on = [azurerm_kubernetes_cluster.mlsc-aks]
  filename   = "kubeconfig"
  content    = azurerm_kubernetes_cluster.mlsc-aks.kube_config_raw
}
