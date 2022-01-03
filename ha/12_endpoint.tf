resource "azurerm_private_dns_zone" "banm_zone" {
    name  = "privatelink.mysql.database.azure.com"
    resource_group_name = azurerm_resource_group.banm_rg.name

    depends_on = [azurerm_mysql_configuration.banm_time]
}

resource "azurerm_private_endpoint" "banm_endpoint" {
    name = "banm-endpoint"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name
    subnet_id = azurerm_subnet.banm_sub4.id

    private_service_connection {
        name = "banm-privateserviceconnection-db"
        private_connection_resource_id = azurerm_mysql_server.banm_myser.id
        is_manual_connection = false
        subresource_names = ["mysqlServer"]
    }

    private_dns_zone_group {
        name = "privatelink-mysql-database-azure-com"
        private_dns_zone_ids = [azurerm_private_dns_zone.banm_zone.id]
    }

    depends_on = [azurerm_private_dns_zone.banm_zone]
}

resource "azurerm_private_dns_zone_virtual_network_link" "banm_link" {
    name = "linkbanm"
    resource_group_name = azurerm_resource_group.banm_rg.name
    private_dns_zone_name = azurerm_private_dns_zone.banm_zone.name
    virtual_network_id = azurerm_virtual_network.banm_vpc.id

    depends_on = [azurerm_private_endpoint.banm_endpoint]
}
