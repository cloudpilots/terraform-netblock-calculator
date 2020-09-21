
variable "base_cidr_block" {
  type        = string
  description = "Base network block to use for caluclations. Specify in CIDR notation i.e. 10.0.0.0/8"
}

variable "networks" {
  type = list(object({
    name     = string
    mask = number
  }))
  description = "A list of networks to calculate network ranges."
}
