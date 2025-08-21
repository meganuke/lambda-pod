provider "aws" {
  alias  = "member"
  region = var.aws_region

  assume_role {
    role_arn     = local.main_account_admin_role
  }
}