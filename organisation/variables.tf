variable "standard_ous" {
  type        = list(any)
  description = "https://docs.aws.amazon.com/whitepapers/latest/organizing-your-aws-environment/recommended-ous.html"
  default = [
    "Sandbox",
    "Security",
    "Infrastructure",
    "Workloads",
  ]
}
