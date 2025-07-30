# Attach AWS-managed EC2 read-only policy to the Developers group
resource "aws_iam_group_policy_attachment" "developers_ec2_readonly" {
  group      = var.developer_group_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess"
}

# Create a custom policy for billing and cost view access
resource "aws_iam_policy" "billing_view_access" {
  name        = "BillingViewAccess"
  description = "Allows viewing of billing, budgets, and cost usage data"
  policy      = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect = "Allow",
        Action = [
          "aws-portal:ViewBilling",
          "budgets:ViewBudget",
          "ce:GetCostAndUsage"
        ],
        Resource = "*"
      }
    ]
  })
}

# Attach the custom billing policy to the Finance group
resource "aws_iam_group_policy_attachment" "finance_billing_view" {
  group      = var.finance_group_name
  policy_arn = aws_iam_policy.billing_view_access.arn
}

# Attach AWS-managed S3 read-only policy to the EC2 role
resource "aws_iam_role_policy_attachment" "ec2_s3_readonly" {
  role       = var.ec2_s3_role_name
  policy_arn = "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"
}
