## VPC Outputs
output "vpc_id" {
  value       = aws_vpc.vpc.id
  description = "VPC Id"
}

output "vpc_cidr" {
  value       = aws_vpc.vpc.cidr_block
  description = "CIDR Block"
}

## Subnet Outputs
output "subnet_ids" {
  value = concat(
    aws_subnet.public_subnets[*].id,
    aws_subnet.private_subnets[*].id,
    aws_subnet.secure_subnets[*].id
  )
  description = "All subnet ids created in the VPC"
}

output "public_subnet_ids" {
  value       = aws_subnet.public_subnets[*].id
  description = "Public subnet ids created in the VPC"
}

output "public_subnet_cidrs" {
  value       = aws_subnet.public_subnets[*].cidr_block
  description = "Public subnet CIDR blocks created in the VPC"
}

output "private_subnet_ids" {
  value       = aws_subnet.private_subnets[*].id
  description = "Private subnet ids created in the VPC"
}

output "private_subnet_cidrs" {
  value       = aws_subnet.private_subnets[*].cidr_block
  description = "Private subnet CIDR blocks created in the VPC"
}

output "secure_subnet_ids" {
  value       = aws_subnet.secure_subnets[*].id
  description = "Secure subnet ids created in the VPC"
}

output "secure_subnet_cidrs" {
  value       = aws_subnet.secure_subnets[*].cidr_block
  description = "Secure subnet CIDR blocks created in the VPC"
}

## Route Table outputs
output "public_rt_ids" {
  value       = aws_route_table.public_route_tables[*].id
  description = "Public route table ids"
}

output "private_rt_ids" {
  value       = aws_route_table.private_route_tables[*].id
  description = "Private route table ids"
}

output "secure_rt_ids" {
  value       = aws_route_table.secure_route_tables[*].id
  description = "Secure route table ids"
}
