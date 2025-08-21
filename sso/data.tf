locals {
  ssoadmin_instance_arn = tolist(data.aws_ssoadmin_instances.this.arns)[0]

  permission_sets = { for ps_name, ps_attrs in var.permission_sets : ps_name => ps_attrs }

  ps_policy_maps = flatten([
    for ps_name, ps_attrs in local.permission_sets : [
      for policy in ps_attrs.managed_policies : {
        ps_name    = ps_name
        policy_arn = policy
      }
    ]
  ])

  account_assignments = flatten([
    for assignment in var.account_assignments : [
      for account_id in assignment.account_ids : {
        sso_group_name = assignment.sso_group_name
        permission_set = aws_ssoadmin_permission_set.this[assignment.permission_set_name]
        account_id     = account_id
      }
    ]
  ])

  sso_groups = distinct([for assignment in var.account_assignments : assignment.sso_group_name])

}

data "aws_ssoadmin_instances" "this" {
  provider = aws.member
}
output "sso_instances" {
  value = data.aws_ssoadmin_instances.this.arns
}

data "aws_identitystore_group" "this" {
  for_each          = toset(local.sso_groups)
  identity_store_id = tolist(data.aws_ssoadmin_instances.this.identity_store_ids)[0]

  alternate_identifier {
    unique_attribute {
      attribute_path  = "DisplayName"
      attribute_value = each.value
    }
  }

  depends_on = [resource.aws_identitystore_group.this]
}
