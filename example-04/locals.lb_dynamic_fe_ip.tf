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
    "pub_ip_3" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name
      location            = module.module_azurerm_resource_group[var.resource_group_name].resource_group.location

      name              = "pub_ip_3"
      allocation_method = "Static"
      sku               = "Standard"
    }
  }

  virtual_networks = {
    (var.virtual_network_name) = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name
      location            = module.module_azurerm_resource_group[var.resource_group_name].resource_group.location

      name          = var.virtual_network_name
      address_space = var.virtual_network_address_space
    }
  }

  subnets = {
    "subnet_0" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name

      name             = "subnet_0"
      vnet_name        = module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.name
      address_prefixes = [cidrsubnet(module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.address_space[0], 8, 0)]
    }
    "subnet_1" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name

      name             = "subnet_1"
      vnet_name        = module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.name
      address_prefixes = [cidrsubnet(module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.address_space[0], 8, 1)]
    }

    "subnet_2" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name

      name             = "subnet_2"
      vnet_name        = module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.name
      address_prefixes = [cidrsubnet(module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.address_space[0], 8, 2)]
    }
    "subnet_3" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name

      name             = "subnet_3"
      vnet_name        = module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.name
      address_prefixes = [cidrsubnet(module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.address_space[0], 8, 3)]
    }
  }

  lbs = {
    "external_lb_1" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name
      location            = module.module_azurerm_resource_group[var.resource_group_name].resource_group.location

      name = "external_lb_1"
      sku  = "Standard"
      frontend_ip_configurations = [
        {
          name                 = "external_lb_1_fe_ip_1"
          public_ip_address_id = module.module_azurerm_public_ip["pub_ip_1"].public_ip.id
        },
        {
          name                 = "external_lb_1_fe_ip_2"
          public_ip_address_id = module.module_azurerm_public_ip["pub_ip_2"].public_ip.id
        }
      ]
    },
    "external_lb_2" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name
      location            = module.module_azurerm_resource_group[var.resource_group_name].resource_group.location

      name = "external_lb_2"
      sku  = "Standard"
      frontend_ip_configurations = [
        {
          name                 = "external_lb_2_fe_ip_1"
          public_ip_address_id = module.module_azurerm_public_ip["pub_ip_3"].public_ip.id
        }
      ]
    },
    "internal_lb_1" = {
      resource_group_name = module.module_azurerm_resource_group[var.resource_group_name].resource_group.name
      location            = module.module_azurerm_resource_group[var.resource_group_name].resource_group.location

      name = "internal_lb_1"
      sku  = "Standard"
      frontend_ip_configurations = [
        {
          name                          = "internal_lb_1_fe_ip_1"
          subnet_id                     = module.module_azurerm_subnet["subnet_0"].subnet.id
          vnet_name                     = module.module_azurerm_virtual_network[var.virtual_network_name].virtual_network.name
          private_ip_address            = cidrhost(module.module_azurerm_subnet["subnet_0"].subnet.address_prefixes[0], 5)
          private_ip_address_allocation = "Static"
          private_ip_address_version    = "IPv4"
        }
      ]
    }
  }
}