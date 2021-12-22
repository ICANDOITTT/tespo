resource "azurerm_public_ip" "banm_elbip" {
    name = "banm-elbip"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name
    allocation_method = "Static"
    sku = "Standard"

    depends_on = [azurerm_bastion_host.banm_bastion]
}

resource "azurerm_lb" "banm_elb" {      #외부 로드밸런서!!
    name = "banm-elb"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name
    sku = "Standard"

    frontend_ip_configuration {
        name = "publicIPAddress"
        public_ip_address_id = azurerm_public_ip.banm_elbip.id
    }

    depends_on = [ azurerm_public_ip.banm_elbip ]
}

resource "azurerm_lb_backend_address_pool" "banm_backend" {
    loadbalancer_id = azurerm_lb.banm_elb.id
    name = "banm-backend"

    depends_on = [ azurerm_lb.banm_elb ]
}

resource "azurerm_lb_probe" "banm_elbprobe" {
    resource_group_name = azurerm_resource_group.banm_rg.name
    loadbalancer_id = azurerm_lb.banm_elb.id
    name = "banm-elbprobe"
    port = 80

    depends_on = [ azurerm_lb_backend_address_pool.banm_backend ]
}

resource "azurerm_lb_rule" "banm_inbound" {
    resource_group_name = azurerm_resource_group.banm_rg.name
    loadbalancer_id = azurerm_lb.banm_elb.id
    name = "banm-inbound"
    frontend_ip_configuration_name = "publicIPAddress"
    backend_address_pool_ids = [ azurerm_lb_backend_address_pool.banm_backend.id ]
    protocol = "Tcp"
    frontend_port = 80
    backend_port = 80
    probe_id = azurerm_lb_probe.banm_elbprobe.id
    disable_outbound_snat = "true"

    depends_on = [ azurerm_lb_probe.banm_elbprobe ]
}

resource "azurerm_lb_outbound_rule" "banm_outb" {
    resource_group_name = azurerm_resource_group.banm_rg.name
    loadbalancer_id = azurerm_lb.banm_elb.id
    name = "banm-outb"
    protocol = "All"
    backend_address_pool_id = azurerm_lb_backend_address_pool.banm_backend.id
    allocated_outbound_ports = "1024"

    frontend_ip_configuration {
        name = "publicIPAddress"
    }

    depends_on = [ azurerm_lb_rule.banm_inbound ]
}