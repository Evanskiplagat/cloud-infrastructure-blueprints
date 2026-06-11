variable "resource_group_name" {
  description = "Name of the target Azure resource group."
  type        = string
  default     = "rg-cib-platform-dev"
}

variable "location" {
  description = "Azure region for monitoring resources."
  type        = string
  default     = "westeurope"
}

variable "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace."
  type        = string
  default     = "log-cib-platform-dev"
}

variable "action_group_name" {
  description = "Name of the Azure Monitor action group."
  type        = string
  default     = "ag-cib-platform-dev"
}

variable "metric_alert_name" {
  description = "Name of the Azure Monitor metric alert."
  type        = string
  default     = "alert-high-cpu-dev"
}

variable "notification_email" {
  description = "Email address that receives example monitoring notifications."
  type        = string
  default     = "platform-team@example.com"
}

variable "target_resource_id" {
  description = "Azure resource ID used by the example metric alert."
  type        = string
}

variable "tags" {
  description = "Standardized tags applied to monitoring resources."
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "cloud-platform"
    managedBy   = "terraform"
  }
}
