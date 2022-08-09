variable "resource_group_name" {
  type        = string
  description = "Resource Group containing the kubernetes service."
}

variable "node_count" {
  type        = number
  description = "Number of nodes to use in the kubernetes cluster."
}

variable "location" {
  type        = string
  default     = "central-india"
  description = "Location of the resource group"
}

variable "acr_name" {
  type        = string
  description = "Name of the Azure Container Registry."
}

variable "aks_name" {
  type        = string
  description = "Kubernetes cluster name"
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version to use"
}
