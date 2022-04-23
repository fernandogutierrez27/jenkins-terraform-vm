resource_group_name         = "terraform-aks-arg"
region                      = "West US 2"
client_id_secret_name       = "sp-tf-id"
client_secret_secret_name   = "sp-tf-password"

kubernetes_cluster = {
    name            = "grupo1-devops-aks"
    dns_prefix      = "aks1"
    network_plugin  = "azure"
    network_policy  = "azure"
    default_node_pool   = {
        name                = "default"
        node_count          = 1
        vm_size             = "Standard_D2_v2"
        enable_auto_scaling = true
        max_count           = 2
        min_count           = 1
    }
}

container_registry = {
    name            = "grupo1devopsacr"
    sku             = "Basic"
    admin_enabled   = true
}

aks_vnet = {
    name            = "grupo1-devops-vnet"
    address_space   = ["12.0.0.0/16"]
}

aks_subnet = {
    name                = "internal"
    address_prefixes    = ["12.0.0.0/20"]
}
