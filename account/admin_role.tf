resource "aws_iam_role" "organisation_admin_role" {
  name = "OrganisationAdmin"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          AWS = compact(concat(
            ["arn:aws:iam::${aws_organizations_account.account.id}:root"],
            var.master_account_id != null ? ["arn:aws:iam::${var.master_account_id}:root"] : []
          ))
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "organisation_admin_role_attachment" {
    role       = aws_iam_role.organisation_admin_role.name
    policy_arn = "arn:aws:iam::aws:policy/AdministratorAccess"
}