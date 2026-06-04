variable "location" {
  description = "Azure region for the landing zone resources."
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
  default     = "rg-cib-platform-dev"
}

variable "storage_account_name_prefix" {
  description = "Prefix for the storage account name; a suffix is added for global uniqueness."
  type        = string
  default     = "cibplatform"
}

variable "tags" {
  description = "Standardized tags applied to all supported resources."
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "cloud-platform"
    workload    = "portfolio"
    managedBy   = "terraform"
  }
}

