# Create Network Security Group and rule
resource "azurerm_network_security_group" "this" {
    name                = "vms-nsg"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    tags                = var.tags

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
    tags                = var.tags

    ip_configuration {
        name                          = "${each.value.name}-nicconf"
        subnet_id                     = var.vm_subnet_id
        private_ip_address_allocation = "Dynamic"
    }
}

resource "azurerm_network_interface_backend_address_pool_association" "this" {
    for_each = var.vm_list

    network_interface_id    = azurerm_network_interface.this[each.key].id
    ip_configuration_name   = "${each.value.name}-nicconf"
    backend_address_pool_id = azurerm_lb_backend_address_pool.this.id
}

# Connect the security group to the network interface
resource "azurerm_network_interface_security_group_association" "this" {
    for_each = var.vm_list

    network_interface_id        = azurerm_network_interface.this[each.key].id
    network_security_group_id   = azurerm_network_security_group.this.id
}

# Generate random text for a unique storage account name
resource "random_id" "randomId" {
  keepers = {
    # Generate a new ID only when a new resource group is defined
    resource_group = azurerm_resource_group.this.name
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
    tags                     = var.tags
}

# Create (and display) an SSH key
resource "tls_private_key" "this" {
    algorithm = "RSA"
    rsa_bits  = 4096
}

resource "azurerm_key_vault_secret" "ssh_private_key" {
    name            = "ansible-vm-ssh"
    value           = tls_private_key.this.private_key_pem
    key_vault_id    = data.azurerm_key_vault.this.id
    tags            = var.tags
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "this" {
    for_each              = var.vm_list
    name                  = "${each.value.name}-vm"
    tags                  = var.tags

    location              = azurerm_resource_group.this.location
    availability_set_id   = azurerm_availability_set.this.id
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
    admin_username                  = "ansibleadmin"
    disable_password_authentication = true

    admin_ssh_key {
        username   = "ansibleadmin"
        public_key = tls_private_key.this.public_key_openssh
    }

    boot_diagnostics {
        storage_account_uri = azurerm_storage_account.this.primary_blob_endpoint
    }
}