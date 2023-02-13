locals {
  resource_groups = {
    (var.resource_group_name) = {
      name     = var.resource_group_name
      location = var.resource_group_location
    }
  }

  public_ips = {
    "pub_ip_1" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name
      location            = module.module_azurerm_resource_group[var.resource_group_name].resource_group.location

      name              = "pub_ip_1"
      allocation_method = "Static"
      sku               = "Standard"
    }
    "pub_ip_2" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name
      location            = module.module_azurerm_resource_group[var.resource_group_name].resource_group.location

      name              = "pub_ip_2"
      allocation_method = "Static"
      sku               = "Standard"
    }
  }
}