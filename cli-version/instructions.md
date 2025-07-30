# CLI Instructions for IAM Users, Groups, Roles, and Permissions

> **Prerequisites**

* AWS CLI installed and configured (`aws configure`)
* Admin access to the AWS account
* Basic terminal navigation skills

---

## 1. **Create IAM Groups**

```bash
aws iam create-group --group-name DevelopersGroup
aws iam create-group --group-name FinanceGroup
```

---

## 2. **Create IAM Users and Add Them to Groups**

```bash
# Create users
aws iam create-user --user-name devuser1
aws iam create-user --user-name devuser2

# (Optional) Set console password for login
aws iam create-login-profile --user-name devuser1 --password 'DevUser1StrongPass!' --password-reset-required
aws iam create-login-profile --user-name devuser2 --password 'DevUser2StrongPass!' --password-reset-required

# Add users to respective groups
aws iam add-user-to-group --user-name devuser1 --group-name DevelopersGroup
aws iam add-user-to-group --user-name devuser2 --group-name FinanceGroup
```

---

## 3. **Attach Policies to Groups**

### a. DevelopersGroup → AmazonEC2ReadOnlyAccess

```bash
aws iam attach-group-policy \
  --group-name DevelopersGroup \
  --policy-arn arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess
```

### b. FinanceGroup → Custom Billing Policy

#### Step 1: Create policy document

Create a file named `billing-policy.json`:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "aws-portal:ViewBilling",
        "budgets:ViewBudget",
        "ce:GetCostAndUsage"
      ],
      "Resource": "*"
    }
  ]
}
```

#### Step 2: Create the policy and attach it

```bash
# Create custom policy
aws iam create-policy \
  --policy-name BillingViewAccess \
  --policy-document file://billing-policy.json

# Attach to FinanceGroup
aws iam attach-group-policy \
  --group-name FinanceGroup \
  --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/BillingViewAccess
```

> **Note**: Replace `<ACCOUNT_ID>` with your actual AWS account ID. You can get it by running:

```bash
aws sts get-caller-identity --query Account --output text
```

---

## 4. **Create IAM Role for EC2 → S3 Access**

### Step 1: Create Trust Policy (trusts EC2)

Create a file named `ec2-trust-policy.json`:

```json
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
```

### Step 2: Create the role and attach policy

```bash
# Create role
aws iam create-role \
  --role-name EC2S3ReadOnlyRole \
  --assume-role-policy-document file://ec2-trust-policy.json

# Attach S3 read-only policy to role
aws iam attach-role-policy \
  --role-name EC2S3ReadOnlyRole \
  --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess
```

---

## 5. **(Optional) Test the Setup**

* Sign in at your IAM login URL as `devuser1` or `devuser2` and test access.
* Launch an EC2 instance and attach the `EC2S3ReadOnlyRole` to test access to S3.

---

## 6. **Cleanup Resources**

```bash
# Detach policies
aws iam detach-group-policy --group-name DevelopersGroup --policy-arn arn:aws:iam::aws:policy/AmazonEC2ReadOnlyAccess
aws iam detach-group-policy --group-name FinanceGroup --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/BillingViewAccess
aws iam detach-role-policy --role-name EC2S3ReadOnlyRole --policy-arn arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess

# Delete login profiles
aws iam delete-login-profile --user-name devuser1
aws iam delete-login-profile --user-name devuser2

# Remove users from groups
aws iam remove-user-from-group --user-name devuser1 --group-name DevelopersGroup
aws iam remove-user-from-group --user-name devuser2 --group-name FinanceGroup

# Delete users
aws iam delete-user --user-name devuser1
aws iam delete-user --user-name devuser2

# Delete groups
aws iam delete-group --group-name DevelopersGroup
aws iam delete-group --group-name FinanceGroup

# Delete custom policy
aws iam delete-policy --policy-arn arn:aws:iam::<ACCOUNT_ID>:policy/BillingViewAccess

# Delete role
aws iam delete-role --role-name EC2S3ReadOnlyRole
```