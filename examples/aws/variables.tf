variable "vpcs" {
  type = list(object({
    name               = string
    cidr               = string
    azs                = list(string)
    private_subnets    = list(string)
    public_subnets     = optional(list(string))
    enable_nat_gateway = optional(bool)
    enable_vpn_gateway = optional(bool)
    single_nat_gateway = optional(bool)
    enable_ipv6        = optional(bool)
    public_subnet_tags = optional(map(string))
    vpc_tags           = optional(map(string))
    tags               = optional(map(string))

  }))
}

variable "tags" {
  type    = map(string)
  default = null
}

locals {
  vpcs = { for i, v in var.vpcs : v.name => v }
}
