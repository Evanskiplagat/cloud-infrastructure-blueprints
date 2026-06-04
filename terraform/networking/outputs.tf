output "virtual_network_id" {
  description = "ID of the platform virtual network."
  value       = azurerm_virtual_network.platform.id
}

output "aks_subnet_id" {
  description = "ID of the AKS subnet."
  value       = azurerm_subnet.aks.id
}

output "app_subnet_id" {
  description = "ID of the application subnet."
  value       = azurerm_subnet.app.id
}

