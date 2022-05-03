resource_group_name         = "terraform-vms-rg"
region                      = "Brazil South"

vm_vnet = {
    name            = "devopslab-vnet"
    address_space   = ["10.0.0.0/16"]
}

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
    }
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
    }
]

akv_name                    = "diplomado-devops-akv"
akv_resource_group          = "diplomado-devops-rg"
# client_id_secret_name       = "sp-tf-id"
# client_secret_secret_name   = "sp-tf-password"