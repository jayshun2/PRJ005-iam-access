# Standard Deliverables (for GUI, CLI, and Terraform versions)
---
## IAM Users
Create the following IAM users:

`devuser1`

`devuser2`

Attributes:

Console access enabled

Custom password set

Assigned to a group (see below)

---

# IAM Groups
Create the following IAM groups:

`DevelopersGroup`

`FinanceGroup`

Group assignments:

devuser1 → `DevelopersGroup`

devuser2 → `FinanceGroup`

--- 

# IAM Policies
Create and attach the following policies:

1. `AmazonEC2ReadOnlyAccess`
Attach to: `DevelopersGroup`

Purpose: Allows viewing EC2 resources, but not modifying them.

2. `BillingViewAccess` (custom policy)
Attach to: `FinanceGroup`

Purpose: Allows users to view billing and cost data.

Policy Definition: Custom JSON with permissions like aws-portal:ViewBilling, budgets:ViewBudget, etc.

--- 

# IAM Role
Create the following IAM role:

`EC2S3ReadOnlyRole`

Attributes:

Trusted entity: `EC2 service`

Permissions: Attach AWS-managed policy `AmazonS3ReadOnlyAccess`

--- 

# Verification Steps (optional but helpful)
Log in as *devuser1* → verify read-only EC2 access

Log in as *devuser2* → verify billing access, no EC2 access

Launch EC2 instance with *EC2S3ReadOnlyRole* → verify it can list S3 buckets