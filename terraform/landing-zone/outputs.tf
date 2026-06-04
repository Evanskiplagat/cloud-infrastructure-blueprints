output "resource_group_name" {
  description = "Name of the shared platform resource group."
  value       = azurerm_resource_group.platform.name
}

output "storage_account_name" {
  description = "Name of the baseline storage account."
  value       = azurerm_storage_account.platform.name
}

