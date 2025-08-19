output "main_account_id" {
  value       = aws_organizations_organization.org.master_account_id
  description = "Main Account Id"
}