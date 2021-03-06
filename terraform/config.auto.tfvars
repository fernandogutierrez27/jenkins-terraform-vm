resource_group_name         = "terraform-vms-rg"
region                      = "Brazil South"
vm_subnet_id                = "/subscriptions/fc8171ee-10a5-4635-8fd1-0c45800663f1/resourceGroups/diplomado-devops-rg/providers/Microsoft.Network/virtualNetworks/diplomado-devops-vnet/subnets/vms-subnet"

vm_list = {
    "vm1" = {
        name    = "vm1"
        size    = "Standard_B1s"
    },
    "vm2" = {
        name    = "vm2"
        size    = "Standard_B1s"
    },
    "vm3" = {
        name    = "vm3"
        size    = "Standard_B1s"
    },
    "vm4" = {
        name    = "vm4"
        size    = "Standard_B1s"
    },
    "vm5" = {
        name    = "vm5"
        size    = "Standard_B1s"
    },
    "vm6" = {
        name    = "vm6"
        size    = "Standard_B1s"
    },
    "vm7" = {
        name    = "vm7"
        size    = "Standard_B1s"
    },
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

tags = {
    "Environment": "Demo"
    "CreatedBy": "fernando.gutierrez@global.ntt"
}

akv_name                    = "diplomado-devops-akv"
akv_resource_group          = "diplomado-devops-rg"