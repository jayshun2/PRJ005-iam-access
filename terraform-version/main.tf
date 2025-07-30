terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Optional: configure a remote backend if desired
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "iam-demo/terraform.tfstate"
  #   region = "us-east-1"
  # }
}

provider "aws" {
  region = "us-east-1"

  # Uses locally configured credentials (e.g., from terraform-user)
  # Make sure `aws configure` has been run or use an environment variable
}
