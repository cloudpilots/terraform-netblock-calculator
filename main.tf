/**
* # terraform netblock calculator
* 
* This module tries to easy the network calculation with terraform.
* 
* The `cidrsubnets` terraform functions allows you to calculate network ranges.
* This function requires you to specify the bits you need for each netblock.
* For pratical reasons it can be more useful to specify network masks instead.
* This is the usecase of this module.
* 
* ## Usage
* 
* This module requires `base_cidr_block` (string) and `networks` (list(object)) as input.
* `base_cidr_block` is the base network super block, which will be used for calculations.
* `networks` is a list of objects, describing the networks to calculate.
* Each network got a name and it's mask. If you want to skip the network in the named outputs, you can set the name to null.
* 
*/

locals {
  mask_regex = "/.*\\//"
  net_regex  = "/\\/.*/"

  base_cidr_block = var.base_cidr_block
  start_bits      = tonumber(replace(local.base_cidr_block, local.mask_regex, ""))
  base_net_addr   = replace(local.base_cidr_block, local.net_regex, "")
  base_bits       = 32 - local.start_bits
  input_nets      = var.networks
  net_bits = [
    for index in range(length(local.input_nets)) : local.input_nets[index].mask - local.start_bits
  ]

  net_blocks = cidrsubnets(local.base_cidr_block, flatten([local.net_bits])...)
  networks = [for i, net in local.input_nets : {
    name       = net.name
    cidr_block = local.net_blocks[i]
    mask       = tonumber(replace(local.net_blocks[i], local.mask_regex, ""))
    net_addr   = replace(local.net_blocks[i], local.net_regex, "")
    new_bits   = local.net_bits[i]
  }]
  named_networks = { for i, net in local.input_nets : net.name => {
    cidr_block = local.net_blocks[i]
    mask       = tonumber(replace(local.net_blocks[i], local.mask_regex, ""))
    net_addr   = replace(local.net_blocks[i], local.net_regex, "")
    new_bits   = local.net_bits[i]
    } if net.name != null
  }
  named_cidrs = {
    for i, net in local.input_nets : net.name => local.net_blocks[i] if net.name != null
  }
}

