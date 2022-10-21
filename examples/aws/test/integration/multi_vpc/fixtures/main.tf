module "test" {
  source = "../../../../"

  vpcs = [
    {
      name               = "jdoll-kitchen-terraform-01"
      cidr               = "10.0.0.0/16"
      azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
      private_subnets    = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
      public_subnets     = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
      enable_ipv6        = false
      enable_nat_gateway = false
      single_nat_gateway = true
      tags = {
        Terraform = "True"
        Kitchen   = "True"
        Workspace = terraform.workspace
      }
    },
    {
      name               = "jdoll-kitchen-terraform-02"
      cidr               = "10.1.0.0/16"
      azs                = ["us-west-2a", "us-west-2b", "us-west-2c"]
      private_subnets    = ["10.1.1.0/24", "10.1.2.0/24", "10.1.3.0/24"]
      public_subnets     = ["10.1.101.0/24", "10.1.102.0/24", "10.1.103.0/24"]
      enable_ipv6        = false
      enable_nat_gateway = false
      single_nat_gateway = true
      tags = {
        Terraform = "True"
        Kitchen   = "True"
        Workspace = terraform.workspace
      }
    }
  ]
}
