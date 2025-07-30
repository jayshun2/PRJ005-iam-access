# Create IAM Groups
resource "aws_iam_group" "developers_group" {
  name = var.developer_group_name
}

resource "aws_iam_group" "finance_group" {
  name = var.finance_group_name
}

# Create IAM Users and Add to Groups
resource "aws_iam_user" "devuser1" {
  name = var.developer_users[0]
}

resource "aws_iam_user_group_membership" "devuser1_membership" {
  user = aws_iam_user.devuser1.name
  groups = [aws_iam_group.developers_group.name]
}

resource "aws_iam_user_login_profile" "devuser1_login" {
  user                    = aws_iam_user.devuser1.name
  password                = "DevUser1TempPass!"
  password_reset_required = true
}

resource "aws_iam_user" "devuser2" {
  name = var.finance_users[0]
}

resource "aws_iam_user_group_membership" "devuser2_membership" {
  user = aws_iam_user.devuser2.name
  groups = [aws_iam_group.finance_group.name]
}

resource "aws_iam_user_login_profile" "devuser2_login" {
  user                    = aws_iam_user.devuser2.name
  password                = "DevUser2TempPass!"
  password_reset_required = true
}

# Create EC2 Role with Trust Policy
data "aws_iam_policy_document" "ec2_trust_policy" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}

resource "aws_iam_role" "ec2_s3_readonly_role" {
  name               = var.ec2_s3_role_name
  assume_role_policy = data.aws_iam_policy_document.ec2_trust_policy.json
}
