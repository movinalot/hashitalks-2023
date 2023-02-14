module "module_azurerm_resource_group" {
  for_each = local.user_resource_groups_map

  source = "../azure/rm/azurerm_resource_group"

  name     = each.value.resource_group_name
  location = each.value.location
}

output "resource_groups" {
  value = var.enable_module_output ? module.module_azurerm_resource_group[*] : null
}

output "user_resource_groups_list" {
  value = var.enable_module_output ? local.user_resource_groups_list : null
}

output "user_resource_groups_map" {
  value = var.enable_module_output ? local.user_resource_groups_map : null
}
