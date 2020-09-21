# terraform netblock calculator

This module tries to easy the network calculation with terraform.

The `cidrsubnets` terraform functions allows you to calculate network ranges.
This function requires you to specify the bits you need for each netblock.
For pratical reasons it can be more useful to specify network masks instead.
This is the usecase of this module.

## Example

```terraform
module "net_calc" {
  source            = "github.com/cloudpilots/terraform-netblock-calculator?ref=v1.0.0"
  base_cidr_block           = "10.0.0.0/8"
  networks = [
    {
      name = "test1"
      mask = 24
    },
    {
      name = "test2"
      mask = 24
    },
    {
      name = "test3"
      mask = 21
    },
    {
      name = "test4"
      mask = 24
    },
    {
      name = "test5"
      mask = 21
    },
  ]
}
```

## Outputs

This are example outputs generated from `terraform apply --var-file=test.tfvars`.

```terraform
base_cidr_block = 10.0.0.0/8
base_net_addr = 10.0.0.0
base_netmask = 8
networks = [
  {
    "cidr_block" = "10.0.0.0/12"
    "mask" = 12
    "name" = "test1"
    "net_addr" = "10.0.0.0"
    "new_bits" = 4
  },
  {
    "cidr_block" = "10.16.0.0/14"
    "mask" = 14
    "name" = "test2"
    "net_addr" = "10.16.0.0"
    "new_bits" = 6
  },
  {
    "cidr_block" = "10.20.0.0/21"
    "mask" = 21
    "name" = "test3"
    "net_addr" = "10.20.0.0"
    "new_bits" = 13
  },
  {
    "cidr_block" = "10.20.8.0/24"
    "mask" = 24
    "name" = "test4"
    "net_addr" = "10.20.8.0"
    "new_bits" = 16
  },
  {
    "cidr_block" = "10.20.16.0/21"
    "mask" = 21
    "name" = "test5"
    "net_addr" = "10.20.16.0"
    "new_bits" = 13
  },
]
```
