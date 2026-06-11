variable "location" {
  description = "Azure region for networking resources."
  type        = string
  default     = "westeurope"
}

variable "resource_group_name" {
  description = "Name of the resource group where networking resources will be deployed."
  type        = string
  default     = "rg-cib-platform-dev"
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
  default     = "vnet-cib-platform-dev"
}

variable "nsg_name" {
  description = "Name of the network security group associated with the shared subnets."
  type        = string
  default     = "nsg-cib-platform-dev"
}

variable "app_subnet_name" {
  description = "Name of the application subnet."
  type        = string
  default     = "snet-app-dev"
}

variable "aks_subnet_name" {
  description = "Name of the AKS subnet."
  type        = string
  default     = "snet-aks-dev"
}

variable "vnet_address_space" {
  description = "CIDR block allocated to the virtual network."
  type        = list(string)
  default     = ["10.20.0.0/16"]
}

variable "app_subnet_prefixes" {
  description = "CIDR ranges for the application subnet."
  type        = list(string)
  default     = ["10.20.1.0/24"]
}

variable "aks_subnet_prefixes" {
  description = "CIDR ranges for the AKS subnet."
  type        = list(string)
  default     = ["10.20.2.0/24"]
}

variable "tags" {
  description = "Standardized tags applied to networking resources."
  type        = map(string)
  default = {
    environment = "dev"
    owner       = "cloud-platform"
    managedBy   = "terraform"
  }
}
