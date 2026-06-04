# Reference an existing resource group so the network stack can be applied independently.
data "azurerm_resource_group" "platform" {
  name = var.resource_group_name
}

# Define the core virtual network used by application and AKS workloads.
resource "azurerm_virtual_network" "platform" {
  name                = var.vnet_name
  location            = data.azurerm_resource_group.platform.location
  resource_group_name = data.azurerm_resource_group.platform.name
  address_space       = var.vnet_address_space
  tags                = var.tags
}

# Create a shared NSG to enforce baseline ingress restrictions.
resource "azurerm_network_security_group" "platform" {
  name                = "nsg-cib-platform-dev"
  location            = data.azurerm_resource_group.platform.location
  resource_group_name = data.azurerm_resource_group.platform.name
  tags                = var.tags

  security_rule {
    name                       = "allow-https-inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

# Separate the application tier from cluster infrastructure for cleaner routing and policy boundaries.
resource "azurerm_subnet" "app" {
  name                 = "snet-app-dev"
  resource_group_name  = data.azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = var.app_subnet_prefixes
}

resource "azurerm_subnet" "aks" {
  name                 = "snet-aks-dev"
  resource_group_name  = data.azurerm_resource_group.platform.name
  virtual_network_name = azurerm_virtual_network.platform.name
  address_prefixes     = var.aks_subnet_prefixes
}

# Associate the NSG with both subnets as a baseline security measure.
resource "azurerm_subnet_network_security_group_association" "app" {
  subnet_id                 = azurerm_subnet.app.id
  network_security_group_id = azurerm_network_security_group.platform.id
}

resource "azurerm_subnet_network_security_group_association" "aks" {
  subnet_id                 = azurerm_subnet.aks.id
  network_security_group_id = azurerm_network_security_group.platform.id
}

