# Reference the shared resource group so monitoring resources can be deployed independently.
data "azurerm_resource_group" "platform" {
  name = var.resource_group_name
}

# Create a Log Analytics workspace for AKS and platform telemetry.
resource "azurerm_log_analytics_workspace" "platform" {
  name                = var.log_analytics_workspace_name
  location            = data.azurerm_resource_group.platform.location
  resource_group_name = data.azurerm_resource_group.platform.name
  sku                 = "PerGB2018"
  retention_in_days   = 30
  tags                = var.tags
}

# Route alert notifications to an operational distribution list.
resource "azurerm_monitor_action_group" "platform" {
  name                = var.action_group_name
  resource_group_name = data.azurerm_resource_group.platform.name
  short_name          = "cibag"
  tags                = var.tags

  email_receiver {
    name          = "platform-email"
    email_address = var.notification_email
  }
}

# Example CPU alert that can be targeted at an AKS node resource or another Azure resource.
resource "azurerm_monitor_metric_alert" "high_cpu" {
  name                = "alert-high-cpu-dev"
  resource_group_name = data.azurerm_resource_group.platform.name
  scopes              = [var.target_resource_id]
  description         = "Alert when CPU usage remains high for the evaluation window."
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"
  tags                = var.tags

  criteria {
    metric_namespace = "Microsoft.ContainerService/managedClusters"
    metric_name      = "node_cpu_usage_percentage"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = 80
  }

  action {
    action_group_id = azurerm_monitor_action_group.platform.id
  }
}

