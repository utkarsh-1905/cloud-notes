resource "azurerm_resource_group" "mlsc-rg" {
  name     = var.resource_group_name
  location = var.location
}

# resource "azurerm_role_assignment" "role_acr" {
#   scope                = azurerm_container_registry.mlsc-cg.id
#   role_definition_name = "Kubernetes Pull Image Role"
#   principal_id         = azurerm_kubernetes_cluster.mlsc-aks.service_principal_id
# }

resource "azurerm_container_registry" "mlsc-cg" {
  name                = var.acr_name
  location            = var.location
  resource_group_name = azurerm_resource_group.mlsc-rg.name
  admin_enabled       = false
  sku                 = "Standard"
}

resource "azurerm_kubernetes_cluster" "mlsc-aks" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = azurerm_resource_group.mlsc-rg.name
  kubernetes_version  = var.kubernetes_version
  dns_prefix          = var.aks_name

  default_node_pool {
    name                = "mlscnodes"
    node_count          = var.node_count
    vm_size             = "Standard_B2s"
    type                = "VirtualMachineScaleSets"
    enable_auto_scaling = false
  }

  identity {
    type = "SystemAssigned"
  }
  #   linux_profile {
  #     admin_username = "admin"
  #     ssh_key= ""
  #   }

  #   network_profile {
  #     load_balancer_sku = "Standard"
  #     network_plugin    = "kubenet"
  #   }
}
