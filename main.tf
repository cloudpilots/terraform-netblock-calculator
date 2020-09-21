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

