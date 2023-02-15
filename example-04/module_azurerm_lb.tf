module "module_azurerm_lb" {
  for_each = local.lbs

  source = "../azure/rm/azurerm_lb"

  resource_group_name        = each.value.resource_group_name
  location                   = each.value.location
  name                       = each.value.name
  sku                        = each.value.sku
  frontend_ip_configurations = each.value.frontend_ip_configurations
}

output "lbs" {
  value = var.enable_module_output ? module.module_azurerm_lb[*] : null
}
