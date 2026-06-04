# Look up the target resource group to keep the stack loosely coupled.
data "azurerm_resource_group" "platform" {
  name = var.resource_group_name
}

# Deploy AKS using a system-assigned identity and Azure CNI networking.
resource "azurerm_kubernetes_cluster" "platform" {
  name                = var.cluster_name
  location            = data.azurerm_resource_group.platform.location
  resource_group_name = data.azurerm_resource_group.platform.name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  tags                = var.tags

  default_node_pool {
    name                 = "system"
    node_count           = 2
    vm_size              = "Standard_D4s_v5"
    orchestrator_version = var.kubernetes_version
    vnet_subnet_id       = var.aks_subnet_id
    type                 = "VirtualMachineScaleSets"
    enable_auto_scaling  = true
    min_count            = 2
    max_count            = 5
    only_critical_addons_enabled = true
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin    = "azure"
    load_balancer_sku = "standard"
    network_policy    = "azure"
  }

  oms_agent {
    log_analytics_workspace_id = var.log_analytics_workspace_id
  }
}

