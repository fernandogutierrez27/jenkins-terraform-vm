# resource "azurerm_public_ip" "this" {
#     for_each = var.vm_list
#     name                = "each.value.name-pip"
#     location            = azurerm_resource_group.this.location
#     resource_group_name = azurerm_resource_group.this.name
#     allocation_method   = "Dynamic"
# }

# Create Network Security Group and rule
resource "azurerm_network_security_group" "this" {
    name                = "vms-nsg"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name

    dynamic "security_rule" {
        for_each = var.nsg_rules
        content {
            name                       = security_rule.value.name
            priority                   = security_rule.value.priority
            direction                  = security_rule.value.direction
            access                     = security_rule.value.access
            protocol                   = security_rule.value.protocol
            source_port_range          = security_rule.value.source_port_range
            destination_port_range     = security_rule.value.destination_port_range
            source_address_prefix      = security_rule.value.source_address_prefix
            destination_address_prefix = security_rule.value.destination_address_prefix
        }
    }
}

# Create network interface
resource "azurerm_network_interface" "this" {
    for_each = var.vm_list

    name                = "${each.value.name}-nic"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name

    ip_configuration {
        name                          = "${each.value.name}-nicconf"
        subnet_id                     = azurerm_subnet.this.id
        private_ip_address_allocation = "Dynamic"
        # public_ip_address_id          = azurerm_public_ip.this.id
    }
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "this" {
    for_each = var.vm_list

    network_interface_id      = azurerm_network_interface.this[each.key].id
    network_security_group_id = azurerm_network_security_group.this.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.rg.name
  }

  byte_length = 8
}

# Create storage account for boot diagnostics
resource "azurerm_storage_account" "this" {
  name                     = "diag${random_id.randomId.hex}stg"
  location                 = azurerm_resource_group.this.location
  resource_group_name      = azurerm_resource_group.this.name
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Create (and display) an SSH key
resource "tls_private_key" "this" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "ssh_private_key" {
    name            = "vm-ssh-${random_id.randomId.hex}"
    value           = tls_private_key.this.private_key_pem
    key_vault_id    = data.azurerm_key_vault.this.id
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "this" {
    for_each = var.vm_list
    name                  = "${each.value.name}-vm"

    location              = azurerm_resource_group.this.location
    resource_group_name   = azurerm_resource_group.this.name
    network_interface_ids = [azurerm_network_interface.this[each.key].id]
    size                  = "${each.value.size}"#"Standard_B1s"

    os_disk {
        name                 = "${each.value.name}-osdisk"
        caching              = "ReadWrite"
        storage_account_type = "Premium_LRS"
    }

    source_image_reference {
        publisher = "Canonical"
        offer     = "UbuntuServer"
        sku       = "18.04-LTS"
        version   = "latest"
    }

    computer_name                   = "${each.value.name}"
    admin_username                  = "root"
    disable_password_authentication = true

    admin_ssh_key {
        username   = "root"
        public_key = tls_private_key.this.public_key_openssh
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.this.primary_blob_endpoint
    }
}