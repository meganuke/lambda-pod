provider "aws" {
  alias  = "member"
  region = var.aws_region
  #assume_role {
  #  role_arn     = local.account_org_admin_role
  #}
}