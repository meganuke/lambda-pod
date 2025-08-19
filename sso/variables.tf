variable "permission_sets" {
  description = "AWS IAM Identity Center permission sets to create."
  type = map(object({
    description      = string
    session_duration = string
    managed_policies = list(string)
    inline_policy    = string
  }))
  default = {
    AdministratorAccess = {
      description      = "Provides full access to AWS services and resources.",
      session_duration = "PT12H",
      managed_policies = ["arn:aws:iam::aws:policy/AdministratorAccess"]
      inline_policy    = ""
    }
  }
}

variable "account_assignments" {
  description = "Assignments of permission sets to AWS IAM Identity Center groups across AWS accounts. Each object in the list contains the group name, the permission set name, and the list of account IDs to which the permission set should be applied."
  type = list(object({
    sso_group_name      = string,
    permission_set_name = string,
    account_ids         = list(string)
  }))

  default = []
}

variable "groups" {
  description = "AWS IAM Identity Center groups to create"
  type = map(object({
    display_name = string,
    description  = string
  }))

  default = {}
}
