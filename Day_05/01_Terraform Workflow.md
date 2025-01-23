## **Terraform Workflow with 5 Stages**

Terraform follows a structured workflow that includes five key stages: **init, validate, plan, apply, and destroy**. These stages ensure efficient infrastructure provisioning, modification, and destruction.

---

### **1. Terraform Init (`terraform init`)**
#### **Purpose**:
- Initializes the working directory.
- Downloads necessary provider plugins.
- Configures the backend (if applicable) for storing the Terraform state.

#### **Command**:
```sh
terraform init
```

#### **Example with AWS**:
We will create an **S3 bucket** using Terraform.

1. **Create a directory and a Terraform file**:
```sh
mkdir terraform-s3 && cd terraform-s3
nano s3.tf
```

2. **Define the S3 bucket (`s3.tf`)**:
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "my_bucket" {
  bucket = "my-terraform-bucket-12345"
  acl    = "private"
}
```

3. **Run `terraform init`**:
```sh
terraform init
```
- This initializes Terraform and downloads the AWS provider.

---

### **2. Terraform Validate (`terraform validate`)**
#### **Purpose**:
- Checks for syntax errors and missing required parameters in the Terraform configuration.
- Ensures configuration files are syntactically valid.

#### **Command**:
```sh
terraform validate
```

#### **Example with AWS**:
Run the following command inside the **terraform-s3** directory:
```sh
terraform validate
```
- If there are no errors, it returns:
  ```
  Success! The configuration is valid.
  ```

---

### **3. Terraform Plan (`terraform plan`)**
#### **Purpose**:
- Generates an execution plan by comparing the current infrastructure with the desired state.
- Shows what changes Terraform will make without applying them.

#### **Command**:
```sh
terraform plan
```

#### **Example with AWS**:
```sh
terraform plan
```
- Expected Output:
  ```
  Plan: 1 to add, 0 to change, 0 to destroy.
  ```

---

### **4. Terraform Apply (`terraform apply`)**
#### **Purpose**:
- Executes the Terraform plan and applies the desired infrastructure changes.

#### **Command**:
```sh
terraform apply
```

#### **Example with AWS**:
```sh
terraform apply -auto-approve
```
- Expected Output:
  ```
  aws_s3_bucket.my_bucket: Creation complete after 3s
  Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
  ```

---

### **5. Terraform Destroy (`terraform destroy`)**
#### **Purpose**:
- Destroys all resources created by Terraform.
- Used for cleanup or deprovisioning.

#### **Command**:
```sh
terraform destroy
```

#### **Example with AWS**:
```sh
terraform destroy -auto-approve
```
- Expected Output:
  ```
  aws_s3_bucket.my_bucket: Destroying...
  aws_s3_bucket.my_bucket: Destruction complete after 2s
  Destroy complete! Resources: 1 destroyed.
  ```

---

### **Summary of Terraform Workflow**
| Stage    | Command               | Purpose |
|----------|----------------------|---------|
| **Init** | `terraform init` | Initializes the Terraform project and downloads required provider plugins. |
| **Validate** | `terraform validate` | Checks configuration syntax and correctness. |
| **Plan** | `terraform plan` | Shows what changes Terraform will make before applying them. |
| **Apply** | `terraform apply` | Creates or updates the resources. |
| **Destroy** | `terraform destroy` | Destroys the infrastructure. |

