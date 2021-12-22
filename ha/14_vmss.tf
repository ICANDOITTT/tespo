resource "azurerm_linux_virtual_machine_scale_set" "banm_vmss" {
    name = "banm-vmss"
    resource_group_name = azurerm_resource_group.banm_rg.name
    location = azurerm_resource_group.banm_rg.location
    sku = "Standard_DS1_v2"
    instances = 2
    disable_password_authentication = false
    computer_name_prefix = "vmss"
    admin_username = "was-vmss"
    admin_password = "gkwltnsmscjswo1!"
    upgrade_mode = "Automatic"

    platform_fault_domain_count = 1

        /*admin_ssh_key {
            username = "was-vmss"
            public_key = azurerm_ssh_public_key.banm_ssh.public_key
        } */

    source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
    }

    os_disk {
      storage_account_type = "Standard_LRS"
      caching = "ReadWrite"
    }

    //health_probe_id = azurerm_lb_probe.banm_ilbprobe.id

    network_interface {
      name = "image-was-nwif"
      primary = true
      network_security_group_id = azurerm_network_security_group.banm_nsg3.id

      ip_configuration {
        name = "subnet03-was"
        primary = true
        subnet_id = azurerm_subnet.banm_sub3.id
        //load_balancer_backend_address_pool_ids = [ azurerm_lb_backend_address_pool.banm_ilb_backend.id ]
        
      public_ip_address {
      name = "banm-vmsstestip"
        }
      }
    }

}

resource "azurerm_monitor_autoscale_setting" "banm_auto" {
  name = "banm-auto"
  resource_group_name = azurerm_resource_group.banm_rg.name
  location = azurerm_resource_group.banm_rg.location
  target_resource_id = azurerm_linux_virtual_machine_scale_set.banm_vmss.id

  profile { 
    name = "autoprofile"

    capacity {
      default = 2
      minimum = 2
      maximum = 6
    }

    rule {
      metric_trigger {
        metric_name = "percentage cpu"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.banm_vmss.id
        time_grain = "PT1M"
        statistic = "Average"
        time_window = "PT5M"
        time_aggregation = "Average"
        operator = "GreaterThan"
        threshold = 60
      }

    scale_action {
      direction = "Increase"
      type = "ChangeCount"
      value = "2"
      cooldown = "PT1M"
    }
  }

  rule {
    metric_trigger {
      metric_name = "percentage cpu"
      metric_resource_id = azurerm_linux_virtual_machine_scale_set.banm_vmss.id
      time_grain = "PT1M"
      statistic = "Average"
      time_window = "PT5M"
      time_aggregation = "Average"
      operator = "LessThan"
      threshold = 40
    }

    scale_action {
      direction = "Decrease"
      type = "ChangeCount"
      value = "2"
      cooldown = "PT1M"
    }
  }
}
}