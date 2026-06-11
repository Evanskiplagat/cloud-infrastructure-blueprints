# Create the resource group that anchors the landing zone resources.
resource "azurerm_resource_group" "platform" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

# Add a randomized suffix because storage account names must be globally unique.
resource "random_string" "storage_suffix" {
  length  = 6
  upper   = false
  special = false
}

# Provision a storage account with secure defaults suitable for state, logs, or shared assets.
resource "azurerm_storage_account" "platform" {
  name                            = "${var.storage_account_name_prefix}${random_string.storage_suffix.result}"
  resource_group_name             = azurerm_resource_group.platform.name
  location                        = azurerm_resource_group.platform.location
  account_tier                    = "Standard"
  account_replication_type        = "LRS"
  account_kind                    = "StorageV2"
  allow_nested_items_to_be_public = false
  min_tls_version                 = "TLS1_2"
  shared_access_key_enabled       = false
  public_network_access_enabled   = false
  tags                            = var.tags
}
