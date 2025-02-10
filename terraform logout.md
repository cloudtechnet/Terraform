### `terraform logout` Command

The `terraform logout` command is used to remove stored credentials for Terraform Cloud or Terraform Enterprise. When you log in using `terraform login`, Terraform saves an authentication token in the local credentials file (`~/.terraform.d/credentials.tfrc.json`). Running `terraform logout` deletes this token, revoking access to Terraform Cloud from the local machine.

### **Syntax**
```bash
terraform logout
```
By default, this logs out from Terraform Cloud (`app.terraform.io`), but you can specify a hostname if you’re using Terraform Enterprise:
```bash
terraform logout hostname.example.com
```

---

## **Example with AWS**
### **Does `terraform logout` Affect AWS?**
No, `terraform logout` is only for logging out of Terraform Cloud. It does not affect AWS authentication because Terraform does not require a login command for AWS. Instead, AWS authentication is managed using:
- **Environment variables (`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`)**
- **AWS credentials file (`~/.aws/credentials`)**
- **IAM roles (if running on AWS instances)**

---

### **Example Scenario: Logging Out of Terraform Cloud and AWS**
#### **Step 1: Authenticate with Terraform Cloud**
```bash
terraform login
```
This stores your credentials in `~/.terraform.d/credentials.tfrc.json`.

#### **Step 2: Authenticate with AWS**
```bash
export AWS_ACCESS_KEY_ID="your-access-key"
export AWS_SECRET_ACCESS_KEY="your-secret-key"
```

Or using AWS CLI:
```bash
aws configure
```
This stores AWS credentials in `~/.aws/credentials`.

#### **Step 3: Logout from Terraform Cloud**
```bash
terraform logout
```
This removes Terraform Cloud credentials.

#### **Step 4: Logout from AWS**
To remove AWS credentials, unset environment variables:
```bash
unset AWS_ACCESS_KEY_ID
unset AWS_SECRET_ACCESS_KEY
```
Or delete the AWS credentials file:
```bash
rm ~/.aws/credentials
```
