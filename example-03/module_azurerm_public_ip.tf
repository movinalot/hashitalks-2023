module "module_azurerm_public_ip" {
  for_each = local.bastion_host["support"] ? {
    for name, user in local.user_resource_groups_map_unfiltered : name => user
    if user.bastion == true
  } : {}

  source = "../azure/rm/azurerm_public_ip"

  resource_group_name = module.module_azurerm_resource_group[each.value.resource_group_name].resource_group.name
  location            = module.module_azurerm_resource_group[each.value.resource_group_name].resource_group.location

  name = format("%s_%s_%s", local.bastion_host["ip_name"], each.value.username, each.value.suffix)

  allocation_method = local.bastion_host["ip_allocation_method"]
  sku               = local.bastion_host["ip_sku"]
}

output "public_ips" {
  value = var.enable_module_output ? module.module_azurerm_public_ip[*] : null
}

output "user_resource_groups_map_unfiltered" {
  value = var.enable_module_output ? local.user_resource_groups_map_unfiltered : null
}
