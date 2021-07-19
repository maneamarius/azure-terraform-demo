locals {

  rgParams = [
    for rgFile in fileset(path.module, "resources/resourceGroups/*.yml"): yamldecode(file(rgFile))
  ]

  RGParams = flatten([
    for rgParam in local.rgParams: [
      for n in rgParam.names: {
          name = n
          location = rgParam.location
          tags = rgParam.tags
      }
    ]
  ])

  adfParams = [
    for adfFile in fileset(path.module, "resources/adf/*.yml"): yamldecode(file(adfFile))
  ]

  ADFParams = flatten([
    for adfParam in local.adfParams: [
      for n in adfParam.names: {
          name = n
          location = adfParam.location
          resourceGroup = adfParam.resourceGroup
          tags = adfParam.tags
      }
    ]
  ])

  NETParams = {
    for networkFile in fileset(path.module, "resources/network/*.yml"):
      networkFile => yamldecode(file(networkFile))
  }

}

module "resourceGroup" {
  for_each = {for r in local.RGParams: r.name => r}
  source          = "./modules/resourceGroup"
  name            = each.value["name"]
  location        = each.value["location"]
  tags            = each.value["tags"]
}

module "adf" {
  for_each = {for a in local.ADFParams: a.name => a}
  source              = "./modules/adf"
  name                = each.value.name
  location            = each.value.location
  resource_group_name = each.value.resourceGroup
  tags                = each.value.tags

  depends_on = [
    module.resourceGroup,
  ]
}

module "network" {
  for_each = {for n in local.NETParams: n.vnet_name => n}
#  for_each = local.NETParams
  source                 = "./modules/network"
  resource_group         = each.value.resourceGroup
  location               = each.value.location
  tags                   = each.value.tags
  vnet_name              = each.value.vnet_name
  address_space          = lookup(each.value, "address_space", null)
  dns_servers            = lookup(each.value, "dns_servers", null)
  subnets                = lookup(each.value, "subnets", null)

  depends_on = [
    module.resourceGroup,
  ]
}
