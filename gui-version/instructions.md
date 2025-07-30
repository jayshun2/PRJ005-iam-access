Firstly:
---
Log in to the AWS Management Console.

Navigate to the IAM service.

Create a user group (e.g., DevelopersGroup) without permissions at first.

Create IAM users (e.g., devuser1) and assign them to the group.

Attach a managed policy (like AmazonEC2ReadOnlyAccess) to the group.

Create an IAM role (e.g., EC2ReadS3Role) with AmazonS3ReadOnlyAccess and assign it to an EC2 instance or service.

---

# Usage
---
Log in as one of the new IAM users using the IAM sign-in URL.

Test their permissions by attempting to access AWS services (e.g., open EC2 and verify read-only access).

If using a role, launch an EC2 instance with that role and validate access to S3 using the AWS CLI from the instance.