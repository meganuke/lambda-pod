provider "aws" {
  alias  = "member"
  region = var.aws_region
  dynamic "profile" {
    for_each = var.aws_profile != null && var.aws_profile != "" ? [var.aws_profile] : []
    content {
      profile = profile.value
    }
  }
  assume_role {
    role_arn     = local.main_account_admin_role
  }
}