resource "azurerm_lb" "banm_ilb" {          #내부 로드밸런서다~
    name = "banm-ilb"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name
    sku = "Standard"

    frontend_ip_configuration {
        name = "privateIPAddress"
        private_ip_address_allocation = "Dynamic"
        subnet_id = azurerm_subnet.banm_sub3.id
    }

    depends_on = [azurerm_private_dns_zone_virtual_network_link.banm_netlink]
}

resource "azurerm_lb_backend_address_pool" "banm_ilb_backend" {
    loadbalancer_id = azurerm_lb.banm_ilb.id
    name = "banm-ilb-backend"

    depends_on = [ azurerm_lb.banm_ilb ]
}

resource "azurerm_lb_probe" "banm_ilbprobe" {
    resource_group_name = azurerm_resource_group.banm_rg.name
    loadbalancer_id = azurerm_lb.banm_ilb.id
    name = "banm-ilbprobe"
    port = 8080

    depends_on = [ azurerm_lb_backend_address_pool.banm_ilb_backend ]
}

resource "azurerm_lb_rule" "banm_ilb_inbound" {
    resource_group_name = azurerm_resource_group.banm_rg.name
    loadbalancer_id = azurerm_lb.banm_ilb.id
    name = "banm-ilb_inbound"
    frontend_ip_configuration_name = "privateIPAddress"
    backend_address_pool_ids = [ azurerm_lb_backend_address_pool.banm_ilb_backend.id ]
    protocol = "Tcp"
    frontend_port = 8080
    backend_port = 8080
    probe_id = azurerm_lb_probe.banm_ilbprobe.id
    disable_outbound_snat = "true"

    depends_on = [ azurerm_lb_probe.banm_ilbprobe ]
}