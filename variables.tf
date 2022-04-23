variable "resource_group_name" {
  description = "El nombre del grupo de recursos donde se generará el cluster"
  type        = string
}

variable "region" {
  description = "La región donde se desplegarán los recursos"
  type        = string
}

variable "kubernetes_cluster" {
    description = "Información básica sobre el cluster de AKS"
    type = object({
        name            = string
        dns_prefix      = string
        network_plugin  = string
        network_policy  = string
        default_node_pool = object({
            name                = string
            node_count          = number
            vm_size             = string
            enable_auto_scaling = bool
            max_count           = number
            min_count           = number
        })
    })
}

variable "container_registry" {
    description = "Configuración básica de ACR"
    type = object({
        name            = string
        sku             = string
        admin_enabled   = bool
    })
}

variable "client_id_secret_name" {
    description = "Nombre del secreto que almacena el client_id del SP"
    type        = string
}

variable "client_secret_secret_name" {
    description = "Nombre del secreto que almacena el client_secret del SP"
    type        = string
}

variable "aks_vnet" {
    description = "Configuración básica para la vnet usada por AKS"
    type = object({
        name            = string
        address_space   = list(string)
    })
}

variable "aks_subnet" {
    description = "Configuración básica para la subnet usada por AKS"
    type = object({
        name                = string
        address_prefixes    = list(string)
    })
}

# variable "tags" {
#   description = "A mapping of tags to assign to the resources."
#   type        = map(any)
# }

# variable "app_service_plan" {
#   description = "Object that contains the details for App Service Plan Resource"
#   type = object({
#     name     = string
#     tier     = string
#     size     = string
#     capacity = string
#     kind     = string
#   })
# }