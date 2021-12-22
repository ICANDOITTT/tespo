resource "azurerm_private_endpoint" "banm_endpoint" {   #그리고 여기는 내부적으로 연동가능하도록 도와주는 endpoint~~
    name = "banm-point01"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name
    subnet_id = azurerm_subnet.banm_sub4.id

    private_service_connection {
        name = "banm-privateconnection"
        private_connection_resource_id = azurerm_mysql_server.banm_myser.id
        is_manual_connection = false
        subresource_names = [ "mysqlServer" ]
    }

    private_dns_zone_group {
        name = "privatelink-mysql-database-azure-com"
        private_dns_zone_ids = [ "/subscriptions/268a434d-f7e6-4966-bb27-d29e20a1b360/resourceGroups/cloud-shell-storage-southeastasia/providers/Microsoft.Network/privateDnsZones/privatelink.mysql.database.azure.com" ]
    }

    depends_on = [ azurerm_mysql_configuration.banm_time ]
}

resource "azurerm_private_dns_zone_virtual_network_link" "banm_netlink" {       #내가 사용하는 vpc와 연결도 해주고~~
    name = "banm-netlink"
    resource_group_name = "cloud-shell-storage-southeastasia"
    private_dns_zone_name = "privatelink.mysql.database.azure.com"
    virtual_network_id = azurerm_virtual_network.banm_vpc.id

    depends_on = [azurerm_private_endpoint.banm_endpoint]
}
