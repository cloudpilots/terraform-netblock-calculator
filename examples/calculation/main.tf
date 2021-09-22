module "net_calc" {
  source          = "github.com/cloudpilots/terraform-netblock-calculator?ref=v1.0.0"
  base_cidr_block = "10.0.0.0/8"
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
}
