resource "azurerm_network_interface" "banm_web_nwif" {
    name = "banm-nwif1"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name

    ip_configuration {
        name = "internal"
        subnet_id = azurerm_subnet.banm_sub2.id
        private_ip_address_allocation = "Dynamic"
    }

    depends_on = [azurerm_lb_outbound_rule.banm_outb]
}

resource "azurerm_network_interface_backend_address_pool_association" "banm_elb_backass" {      
    network_interface_id = azurerm_network_interface.banm_web_nwif.id
    ip_configuration_name = "internal"
    backend_address_pool_id = azurerm_lb_backend_address_pool.banm_backend.id

    depends_on = [ azurerm_network_interface.banm_web_nwif ]
}