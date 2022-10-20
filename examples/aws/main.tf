module "this" {
  for_each           = local.vpcs
  source             = "terraform-aws-modules/vpc/aws"
  version            = "3.16.1"
  name               = each.value.name
  cidr               = each.value.cidr
  azs                = each.value.azs
  private_subnets    = each.value.private_subnets
  public_subnets     = coalesce(each.value.public_subnets, [])
  enable_nat_gateway = coalesce(each.value.enable_nat_gateway, false)
  enable_vpn_gateway = coalesce(each.value.enable_vpn_gateway, false)
  single_nat_gateway = coalesce(each.value.single_nat_gateway, false)
  enable_ipv6        = coalesce(each.value.enable_ipv6, false)
  public_subnet_tags = coalesce(merge(each.value.public_subnet_tags, var.tags), tomap({}))
  vpc_tags           = coalesce(merge(each.value.vpc_tags, var.tags), tomap({}))
  tags               = coalesce(merge(each.value.tags, var.tags), tomap({}))

}
