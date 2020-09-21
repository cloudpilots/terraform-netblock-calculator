output "networks" {
  description = "list of networks extended with CIDR block"
  value       = local.networks
}

output "base_netmask" {
  description = "base network mask"
  value       = local.start_bits
}

output "base_net_addr" {
  description = "description"
  value       = local.base_net_addr
}

output "base_cidr_block" {
  description = "mirrors input variable"
  value       = local.base_cidr_block
}

