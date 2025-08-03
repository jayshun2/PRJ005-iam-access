# PRJ005-iam-access

# Create IAM Users, Groups, and Roles with Fine-Grained Permissions — GUI Version

## Overview

This project demonstrates how to securely manage AWS account access using the **AWS Management Console (GUI)**. You’ll create IAM users, organize them into groups, and assign permissions through policies and roles — all while applying the principle of least privilege.

The focus here is on understanding IAM fundamentals by building them visually through the AWS Console. While this README covers the **GUI implementation**, there are also CLI and Terraform approaches that can achieve the same deliverables.

---

## Architecture

This project uses **AWS Identity and Access Management (IAM)** to build:

* **Users** – Individual identities for people who need to log into AWS.
* **Groups** – Collections of users with shared permissions (e.g., Developers, Finance).
* **Roles** – Temporary or special-purpose access identities for services or cross-account use.
* **Policies** – Documents defining what actions are allowed or denied.

In this version, all resources are created via the AWS Console, with policies applied directly to groups or roles. Users inherit permissions from their group, and roles have permissions defined by their attached policies.

---

## Getting Started (GUI Version)

1. **Sign in to the AWS Console** using an administrator account.
2. **Create Groups**:

   * `DevelopersGroup`
   * `FinanceGroup`
3. **Create Users**:

   * `devuser1` → Add to `DevelopersGroup`
   * `devuser2` → Add to `FinanceGroup`
4. **Attach Policies**:

   * `DevelopersGroup` → Attach `AmazonEC2ReadOnlyAccess`
   * `FinanceGroup` → Create and attach a custom `BillingViewAccess` policy
5. **Create a Role**:

   * `EC2S3ReadOnlyRole` → Trusted entity: EC2 → Attach `AmazonS3ReadOnlyAccess`

---

## Testing

* Sign in as `devuser1` using the IAM login link from the Dashboard. Verify they can **view** EC2 instances but cannot modify them.
* Sign in as `devuser2` and verify they can access the **Billing** section but have no EC2 permissions.
* (Optional) Launch an EC2 instance with the `EC2S3ReadOnlyRole` to confirm it can access S3 buckets.

---

## Cleanup

To keep your account secure and tidy:

1. Delete test users.
2. Remove groups.
3. Delete custom policies.
4. Delete the role if no longer needed.
5. Terminate any EC2 instances created for testing.

---

## Optional Enhancements

* Enable **MFA** for all IAM users.
* Add **tags** to IAM resources for better organization.
* Explore automating this setup with the AWS CLI or Terraform.

---

## License

MIT License
