# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/organizations_account#attributes-reference
output "account_id" {
  value       = aws_organizations_account.account.id
  description = "The AWS Account Id of the created account."
}

output "account_arn" {
  value       = aws_organizations_account.account.arn
  description = "The AWS Account ARN of the created account."
}

output "account_email" {
  value       = aws_organizations_account.account.email
  description = "The AWS Account email of the created account."
}
