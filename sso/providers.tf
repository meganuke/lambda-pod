provider "aws" {
  alias  = "member"
  region = var.aws_region
  profile = var.aws_profile != null && var.aws_profile != "" ? var.aws_profile : null
   
  assume_role {
    role_arn     = local.main_account_admin_role
  }
}