resource "azurerm_mysql_server" "banm_myser" {
    name = "banm-myser"
    location = azurerm_resource_group.banm_rg.location
    resource_group_name = azurerm_resource_group.banm_rg.name 
    
    administrator_login = "nana"
    administrator_login_password = "gkwltnsmscjswo1!"

    sku_name = "GP_Gen5_2"
    storage_mb = 5120
    version = "5.7"

    auto_grow_enabled = false
    backup_retention_days = 7
    geo_redundant_backup_enabled = true
    infrastructure_encryption_enabled = false 
    public_network_access_enabled = true
    ssl_enforcement_enabled = false

    depends_on = [ azurerm_virtual_machine_extension.banm_vmex_web ]
}


resource "azurerm_mysql_database" "banm_db" {
    name = "petclinic"
    resource_group_name = azurerm_resource_group.banm_rg.name
    server_name = azurerm_mysql_server.banm_myser.name
    charset = "utf8"
    collation = "utf8_unicode_ci"

    depends_on = [ azurerm_mysql_server.banm_myser ]
}

resource "azurerm_mysql_configuration" "banm_time" {
    name = "time_zone"
    resource_group_name = azurerm_resource_group.banm_rg.name

    server_name = azurerm_mysql_server.banm_myser.name
    value = "+09:00"

    depends_on = [ azurerm_mysql_database.banm_db ]
}
