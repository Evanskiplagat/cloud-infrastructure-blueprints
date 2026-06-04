variable "resource_group_name" {
  description = "Name of the Azure resource group that contains AKS resources."
  type        = string
  default     = "rg-cib-platform-dev"
}

variable "location" {
  description = "Azure region for the AKS cluster."
  type        = string
  default     = "westeurope"
}

variable "cluster_name" {
  description = "AKS cluster name."
  type        = string
  default     = "aks-cib-platform-dev"
}

variable "dns_prefix" {
  description = "DNS prefix used by the AKS API server."
  type        = string
  default     = "aks-cib-platform-dev"
}

variable "kubernetes_version" {
  description = "Kubernetes version pin for the AKS cluster."
  type        = string
  default     = "1.29.4"
}

variable "aks_subnet_id" {
  description = "Subnet ID where AKS nodes will be attached."
  type        = string
}

variable "log_analytics_workspace_id" {
  description = "Existing Log Analytics workspace ID used for Container Insights."
  type        = string
}

variable "tags" {
  description = "Standardized tags applied to AKS resources."
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "cloud-platform"
    managedBy   = "terraform"
  }
}

