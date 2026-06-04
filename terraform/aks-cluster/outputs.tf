output "aks_cluster_name" {
  description = "Name of the deployed AKS cluster."
  value       = azurerm_kubernetes_cluster.platform.name
}

output "aks_kube_config_command" {
  description = "Example command for fetching cluster credentials."
  value       = "az aks get-credentials --resource-group ${data.azurerm_resource_group.platform.name} --name ${azurerm_kubernetes_cluster.platform.name}"
}

