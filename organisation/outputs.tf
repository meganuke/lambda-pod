output "main_account_id" {
  value       = aws_organizations_organization.org.master_account_id
  description = "Main Account Id"
}

output "workload_ou_id" {
  value       = aws_organizations_organizational_unit.standard_ous["Workloads"].id
  description = "AWS Organization Organizational Unit Id for the Workloads OU"
}