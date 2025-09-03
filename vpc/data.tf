# Grabs what AZs are available in the region
data "aws_availability_zones" "available" {
  state = "available"
}

locals {
  environment = "${var.naming_prefix}-${var.aws_region}"
  vpc_cidr    = "${var.network_prefix}.0.0/${var.vpc_cidr_block}"
  # This looks gnarly but simply splits the vpc up into 16 subnets - giving 4 bits to each and 12 to tgw subnets
  subnet_cidrs  = cidrsubnets(local.vpc_cidr, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 12, 12, 12, 12)
  azs           = data.aws_availability_zones.available.names
  number_of_azs = 3 # Hardcoded 
}