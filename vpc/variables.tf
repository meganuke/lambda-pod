variable "naming_prefix" {
  description = "Customer's name for prefixing resources, should be identitiy-workload, e.g. itoc-shared"
  type        = string
}

variable "vpc_cidr_block" {
  description = "VPC Network CIDR block"
  type        = string
  default     = "16"
}

variable "network_prefix" {
  description = "First two octets for VPC IP range"
  type        = string
}

variable "create_s3_gateway" {
  description = "Create an S3 Gateway, defaults to true."
  type        = bool
  default     = true
}

variable "create_dynamo_gateway" {
  description = "Create a Dynamo Gateway, defaults to true."
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "Instance tenancy for VPC"
  type        = string
  default     = "default"
}

variable "tags" {
  description = "Additional tags to add to resources. Defaults to empty."
  type        = map(string)
  default     = {}
}

variable "number_of_ngws" {
  description = "Number of NAT Gateways to create, defaults to 0"
  type        = number
  default     = 0
}

variable "enable_eks_tags" {
  type        = string
  description = "Tag subnets with tags needed for EKS. Defaults to false."
  default     = "false"
}

variable "eks_public_nodes" {
  type        = string
  description = "Controls whether to tag public subnets for EKS usage. Defaults to false."
  default     = "false"
}

variable "flow_log_bucket_arn" {
  type        = string
  description = "S3 bucket ARN of where to send flow logs."
  default     = ""
}

variable "vpc_interface_endpoints" {
  type        = list(any)
  description = "AWS services to create endpoints for. Defaults to none"
  default     = []
}

variable "aws_region" {
  type        = string
  description = "AWS Region to set up account for"
}