# terraform netblock calculator

This module tries to easy the network calculation with terraform.

The `cidrsubnets` terraform functions allows you to calculate network ranges.
This function requires you to specify the bits you need for each netblock.
For pratical reasons it can be more useful to specify network masks instead.
This is the usecase of this module.

## Usage

This module requires `base_cidr_block` (string) and `networks` (list(object)) as input.
`base_cidr_block` is the base network super block, which will be used for calculations.
`networks` is a list of objects, describing the networks to calculate.
Each network got a name and it's mask. If you want to skip the network in the named outputs, you can set the name to null.

## Example

```terraform
module "net_calc" {
  source            = "github.com/cloudpilots/terraform-netblock-calculator?ref=v1.0.0"
  base_cidr_block   = "10.0.0.0/8"
  networks = [
    {
      name = null
      mask = 24
    },
    {
      name = "test2"
      mask = 21
    },
    {
      name = "test3"
      mask = 24
    },
  ]
```

## Outputs

This are example outputs generated from `terraform apply --var-file=test.tfvars`.

```terraform
base_cidr_block = 10.0.0.0/8
base_net_addr   = 10.0.0.0
base_netmask    = 8
named_cidrs     = {
  "test2" = "10.0.8.0/21"
  "test3" = "10.0.16.0/24"
}
named_networks  = {
  "test2" = {
    "cidr_block" = "10.0.8.0/21"
    "mask" = 21
    "net_addr" = "10.0.8.0"
    "new_bits" = 13
  }
  "test3" = {
    "cidr_block" = "10.0.16.0/24"
    "mask" = 24
    "net_addr" = "10.0.16.0"
    "new_bits" = 16
  }
}
networks        = [
  {
    "cidr_block" = "10.0.0.0/24"
    "mask" = 24
    "net_addr" = "10.0.0.0"
    "new_bits" = 16
  },
  {
    "cidr_block" = "10.0.8.0/21"
    "mask" = 21
    "name" = "test2"
    "net_addr" = "10.0.8.0"
    "new_bits" = 13
  },
  {
    "cidr_block" = "10.0.16.0/24"
    "mask" = 24
    "name" = "test3"
    "net_addr" = "10.0.16.0"
    "new_bits" = 16
  },
]
```
