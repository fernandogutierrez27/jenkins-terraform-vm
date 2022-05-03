resource_group_name         = "terraform-vms-rg"
region                      = "Brazil South"

vm_subnet = {
    name                = "vms-subnet"
    address_prefixes    = ["10.0.1.0/24"]
    resource_group      = "diplomado-devops-rg"
    vnet_name           = "diplomado-devops-vnet"
}

vm_list = {
    "vm1" = {
        name    = "vm1"
        size    = "Standard_B1s"
    },
    # "vm2" = {
    #     name    = "vm2"
    #     size    = "Standard_B1s"
    # },
    # "vm3" = {
    #     name    = "vm3"
    #     size    = "Standard_B1s"
    # }
}

nsg_rules = [
    {
        name                       = "SSH"
        priority                   = 1001
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "22"
        source_address_prefix      = "10.0.0.0/24"
        destination_address_prefix = "*"
    },
    {
        name                       = "HTTP"
        priority                   = 1002
        direction                  = "Inbound"
        access                     = "Allow"
        protocol                   = "Tcp"
        source_port_range          = "*"
        destination_port_range     = "80"
        source_address_prefix      = "*"
        destination_address_prefix = "*"
    }
]

akv_name                    = "diplomado-devops-akv"
akv_resource_group          = "diplomado-devops-rg"
# client_id_secret_name       = "sp-tf-id"
# client_secret_secret_name   = "sp-tf-password"