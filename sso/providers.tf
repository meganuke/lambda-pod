provider "aws" {
  alias  = "member"
  region = var.aws_region
  profile = "lambda_pod_main"
}