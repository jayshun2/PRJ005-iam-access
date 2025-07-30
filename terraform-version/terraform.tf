# Project-wide variables for user, group, and role names

variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "developer_users" {
  description = "List of developer IAM usernames"
  type        = list(string)
  default     = ["devuser1"]
}

variable "finance_users" {
  description = "List of finance IAM usernames"
  type        = list(string)
  default     = ["devuser2"]
}

variable "developer_group_name" {
  description = "IAM group for developers"
  type        = string
  default     = "DevelopersGroup"
}

variable "finance_group_name" {
  description = "IAM group for finance users"
  type        = string
  default     = "FinanceGroup"
}

variable "ec2_s3_role_name" {
  description = "IAM role that allows EC2 to read S3"
  type        = string
  default     = "EC2S3ReadOnlyRole"
}
