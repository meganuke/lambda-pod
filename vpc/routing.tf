resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${local.environment}-igw"
    },
    var.tags
  )
}

# NAT Gateways
resource "aws_eip" "nat_gw_eips" {
  count  = var.number_of_ngws
  domain = "vpc"
  tags = merge({
    Name = "${local.environment}-nat-gw-${trimprefix(local.azs[count.index], var.aws_region)}"
    },
    var.tags
  )
}

resource "aws_nat_gateway" "nat_gws" {
  count         = var.number_of_ngws
  allocation_id = aws_eip.nat_gw_eips[count.index].id
  subnet_id     = aws_subnet.public_subnets[count.index].id
  tags = merge({
    Name = "${local.environment}-nat-gw-${trimprefix(local.azs[count.index], var.aws_region)}"
    },
    var.tags
  )
}

resource "aws_route_table" "public_route_tables" {
  count = local.number_of_azs

  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${local.environment}-public-rt-${trimprefix(local.azs[count.index], var.aws_region)}"
    },
    var.tags
  )
}

resource "aws_route_table_association" "rt_assocations_public" {
  count          = local.number_of_azs
  subnet_id      = aws_subnet.public_subnets[count.index].id
  route_table_id = aws_route_table.public_route_tables[count.index].id
}

resource "aws_route" "public_to_igw" {
  count                  = local.number_of_azs
  route_table_id         = aws_route_table.public_route_tables[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table" "private_route_tables" {
  count = local.number_of_azs

  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${local.environment}-private-rt-${trimprefix(local.azs[count.index], var.aws_region)}"
    },
    var.tags
  )
}

resource "aws_route_table_association" "rt_assocations_private" {
  count          = local.number_of_azs
  subnet_id      = aws_subnet.private_subnets[count.index].id
  route_table_id = aws_route_table.private_route_tables[count.index].id
}

resource "aws_route" "private_to_ngw" {
  count                  = var.number_of_ngws == 0 ? 0 : local.number_of_azs
  route_table_id         = aws_route_table.private_route_tables[count.index].id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id = count.index >= var.number_of_ngws ? aws_nat_gateway.nat_gws[0].id : aws_nat_gateway.nat_gws[count.index].id
}

resource "aws_route_table" "secure_route_tables" {
  count = local.number_of_azs

  vpc_id = aws_vpc.vpc.id

  tags = merge({
    Name = "${local.environment}-secure-rt-${trimprefix(local.azs[count.index], var.aws_region)}"
    },
    var.tags
  )
}

resource "aws_route_table_association" "rt_assocations_secure" {
  count          = local.number_of_azs
  subnet_id      = aws_subnet.secure_subnets[count.index].id
  route_table_id = aws_route_table.secure_route_tables[count.index].id
}
