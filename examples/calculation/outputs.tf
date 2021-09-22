base_cidr_block = "10.0.0.0/8"
base_net_addr   = "10.0.0.0"
base_netmask    = 8
named_cidrs = {
  "test2" = "10.0.8.0/21"
  "test3" = "10.0.16.0/24"
}
named_networks = {
  "test2" = {
    "cidr_block" = "10.0.8.0/21"
    "mask"       = 21
    "net_addr"   = "10.0.8.0"
    "new_bits"   = 13
  }
  "test3" = {
    "cidr_block" = "10.0.16.0/24"
    "mask"       = 24
    "net_addr"   = "10.0.16.0"
    "new_bits"   = 16
  }
}
networks = [
  {
    "cidr_block" = "10.0.0.0/24"
    "mask"       = 24
    "net_addr"   = "10.0.0.0"
    "new_bits"   = 16
  },
  {
    "cidr_block" = "10.0.8.0/21"
    "mask"       = 21
    "name"       = "test2"
    "net_addr"   = "10.0.8.0"
    "new_bits"   = 13
  },
  {
    "cidr_block" = "10.0.16.0/24"
    "mask"       = 24
    "name"       = "test3"
    "net_addr"   = "10.0.16.0"
    "new_bits"   = 16
  },
]
