## 🔧 GUI Instructions for IAM Setup (AWS Console)
*untested, please excersize caution before execution*
---

### 1. **Create IAM Groups**

#### a. DevelopersGroup

1. Go to **IAM** in the AWS Console.
2. In the left sidebar, click **“User groups”** → then **“Create group”**.
3. **Group name**: `DevelopersGroup`
4. Click **Next** → **Next** again (don’t attach permissions yet) → **Create group**

#### b. FinanceGroup

Repeat the steps above with **Group name**: `FinanceGroup`.

---

### 2. **Create IAM Users and Add to Groups**

#### a. devuser1 → DevelopersGroup

1. In IAM sidebar, click **“Users”** → **“Add users”**
2. **User name**: `devuser1`
3. **Access type**:

   * Check **"AWS Management Console access"**
   * Select **"Custom password"** and set a temporary password
   * (Optional) Uncheck "Require password reset"
4. Click **Next**
5. Select **“Add user to group”** → Check **DevelopersGroup**
6. Click **Next** → **Create user**

#### b. devuser2 → FinanceGroup

Repeat the same steps with:

* **User name**: `devuser2`
* **Group**: `FinanceGroup`

---

### 3. **Attach Policies to Groups**

#### a. DevelopersGroup → AmazonEC2ReadOnlyAccess

1. IAM → **User groups** → Click **DevelopersGroup**
2. Go to the **Permissions** tab → Click **“Add permissions”**
3. Choose **“Attach policies directly”**
4. Search for and select: `AmazonEC2ReadOnlyAccess`
5. Click **Next** → **Add permissions**

#### b. FinanceGroup → Custom Billing Policy

1. IAM → **Policies** → Click **Create policy**
2. **Choose JSON tab**, paste the following policy:

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

3. Click **Next** → Name it `BillingViewAccess` → Click **Create policy**
4. Go back to **User groups** → Click **FinanceGroup**
5. Under **Permissions** tab → Click **Add permissions**
6. Choose **“Attach policies directly”** → Search and select `BillingViewAccess`
7. Click **Next** → **Add permissions**

---

### 4. **Create IAM Role for EC2 Access to S3**

1. IAM → Click **Roles** → **Create role**
2. Choose **Trusted entity**: `AWS service`
3. Use case: **EC2** → Click **Next**
4. Attach AWS managed policy: `AmazonS3ReadOnlyAccess`
5. Click **Next**
6. **Role name**: `EC2S3ReadOnlyRole` → Click **Create role**

---

### 5. **Test the Setup (Optional)**

* Sign in as `devuser1` at your IAM login link (found in IAM → Dashboard).

  * Verify you can *view* EC2 resources but **not** launch or terminate instances.
* Sign in as `devuser2` and verify access to **billing dashboard**.
* Launch an EC2 instance with the `EC2S3ReadOnlyRole` and verify it can access S3 buckets (CLI or test script required).

---

### 6. **Cleanup Steps**

To avoid clutter or potential future charges:

1. Go to **IAM → Users** and delete `devuser1` and `devuser2`
2. Delete `DevelopersGroup` and `FinanceGroup` under **User groups**
3. Delete the custom policy `BillingViewAccess` under **Policies**
4. Delete the role `EC2S3ReadOnlyRole` under \*\*Roles\`
5. Terminate any EC2 instances launched for testing