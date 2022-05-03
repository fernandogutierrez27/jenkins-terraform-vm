variable "resource_group_name" {
  description = "El nombre del grupo de recursos donde se generará el cluster"
  type        = string
}

variable "region" {
  description = "La región donde se desplegarán los recursos"
  type        = string
}

variable "vm_subnet" {
    description = "Configuración básica para la subnet usada por las VMs"
    type = object({
        name                = string
        address_prefixes    = list(string)
        resource_group      = string
        vnet_name           = string
    })
}

variable "akv_name" {
  description = "El nombre del Azure Key Vault que almacena los secretos"
  type        = string
}

variable "akv_resource_group" {
  description = "El nombre del resource group donde se encuentra el Azure Key Vault"
  type        = string
}

variable "vm_list" {
    description = "Listado de VMs a crear"
    type = map(
        object({
            vm_name = string
            size    = string
        })
    )
}

variable "nsg_rules" {
    description = "Listado de NSG rules a aplicar"
    type = list(
        object({
            name                       = string
            priority                   = number
            direction                  = string
            access                     = string
            protocol                   = string
            source_port_range          = string
            destination_port_range     = string
            source_address_prefix      = string
            destination_address_prefix = string
        })
    )
}

# variable "client_id_secret_name" {
#     description = "Nombre del secreto que almacena el client_id del SP"
#     type        = string
# }

# variable "client_secret_secret_name" {
#     description = "Nombre del secreto que almacena el client_secret del SP"
#     type        = string
# }