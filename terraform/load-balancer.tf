resource "azurerm_public_ip" "this" {
    name                = "devopslab-lb-pip"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name
    allocation_method   = "Dynamic"
}

resource "azurerm_lb" "this" {
    name                = "devopslab-lb"
    location            = azurerm_resource_group.this.location
    resource_group_name = azurerm_resource_group.this.name

    frontend_ip_configuration {
        name                 = "PublicIPAddress"
        public_ip_address_id = azurerm_public_ip.this.id
    }
}

resource "azurerm_lb_rule" "http" {
    loadbalancer_id                = azurerm_lb.this.id
    name                           = "HttpRule"
    protocol                       = "Tcp"
    frontend_port                  = 80
    backend_port                   = 80
    frontend_ip_configuration_name = "PublicIPAddress"
}

resource "azurerm_lb_backend_address_pool" "this" {
    loadbalancer_id     = azurerm_lb.this.id
    name                = "BackEndAddressPool"
}

resource "azurerm_availability_set" "this" {
    name                         = "devopslab-avset"
    location                     = azurerm_resource_group.this.location
    resource_group_name          = azurerm_resource_group.this.name
    platform_fault_domain_count  = 2
    platform_update_domain_count = 2
    managed                      = true
}