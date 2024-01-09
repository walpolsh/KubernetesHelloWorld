variable "ssh_key" {
  description = "The public SSH key for AKS authentication."
  type        = string
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "aks_rg" {
  name     = "AKSExperimentResourceGroup"
  location = "canadaeast"
}

resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = "NewAKSExperimentCluster"
  location            = azurerm_resource_group.aks_rg.location
  resource_group_name = azurerm_resource_group.aks_rg.name
  dns_prefix          = "newaksexpe"
  kubernetes_version  = "1.27.7"

  default_node_pool {
    name                = "nodepool1"
    node_count          = 1
    vm_size             = "Standard_B2s"
    os_disk_size_gb     = 128
    os_disk_type        = "Managed"
    type                = "VirtualMachineScaleSets"
    max_pods            = 110
    orchestrator_version = "1.27.7"
  }

  identity {
    type = "SystemAssigned"
  }

  network_profile {
    network_plugin = "kubenet"
    service_cidr   = "10.0.0.0/16"
    dns_service_ip = "10.0.0.10"
    pod_cidr       = "10.244.0.0/16"
    load_balancer_sku = "standard"
  }

  linux_profile {
    admin_username = "azureuser"
    ssh_key {
      key_data = var.ssh_key
    }
  }

  tags = {
    Environment = "Experiment"
  }
}

output "client_certificate" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.client_certificate
}

output "kube_config" {
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config_raw
  sensitive = true
}

output "host" {
  value = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.host
  sensitive = true
}

output "cluster_ca_certificate" {
  sensitive = true
  value     = azurerm_kubernetes_cluster.aks_cluster.kube_config.0.cluster_ca_certificate
}
