locals {

  users = {
    "user01" = { name = "user01" }
    "user02" = { name = "user02" }
    "user03" = { name = "user03" }
  }

  resource_groups = [
    {
      suffix   = "training"
      location = "eastus"
      storage  = true
      bastion  = true
    },
    {
      suffix   = "utility"
      location = "southcentralus"
      storage  = false
      bastion  = false
    },
    {
      suffix   = "qa"
      location = "westus"
      storage  = false
      bastion  = false
    }
  ]

  # 3 users each with 3 resource groups is 9 resource groups

  # Create a list of User and Resource Group Sets
  user_resource_groups_list = setproduct(values(local.users), local.resource_groups)

  # Create a map of User and Resource Group Sets from the list
  user_resource_groups_map = {
    for item in local.user_resource_groups_list :
    format("%s-%s", item[0]["name"], item[1]["suffix"]) => {
      username            = item[0]["name"],
      resource_group_name = format("%s-%s", item[0]["name"], item[1]["suffix"]),
      suffix              = item[1]["suffix"],
      location            = item[1]["location"],
      storage             = item[1]["storage"],
      bastion             = item[1]["bastion"],
    }
  }
}