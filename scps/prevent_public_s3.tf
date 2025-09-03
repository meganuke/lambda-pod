resource "aws_organizations_policy" "prevent_public_s3" {
  name = "Prevent creation of public s3 buckets"

  content = <<CONTENT
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "s3:PutAccountPublicAccessBlock"
      ],
      "Resource": "*",
      "Effect": "Deny"
    }
  ]
}
CONTENT
}

resource "aws_organizations_policy_attachment" "prevent_public_s3_attach" {
  policy_id = aws_organizations_policy.prevent_public_s3.id
  target_id = var.main_account_id
}
