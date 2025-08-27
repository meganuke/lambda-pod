locals {
  main_account_admin_role = "arn:aws:iam::${aws_organizations_account.account.id}:role/OrganisationAdmin"
}
