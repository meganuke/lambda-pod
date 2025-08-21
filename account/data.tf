locals {
  main_account_admin_role = "arn:aws:iam::${var.master_account_id}:role/${var.role_name}"
}
