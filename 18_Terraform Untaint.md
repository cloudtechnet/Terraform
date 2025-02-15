### **Terraform `untaint` Command**

The `terraform untaint` command is used to remove the "tainted" status from a resource. In Terraform, when a resource is marked as **tainted**, it means Terraform will destroy and recreate it in the next `terraform apply`. If you no longer want to replace the resource, you can use the `untaint` command to clear the tainted status.

#### **Syntax:**
```bash
terraform untaint <resource_type>.<resource_name>
```

#### **Use Case**
If a resource was mistakenly tainted or no longer needs to be replaced, running `terraform untaint` will prevent Terraform from recreating it in the next apply.

---

## **Example: Using `untaint` in AWS**
Let's consider an AWS EC2 instance managed by Terraform.

### **Step 1: Create an EC2 instance using Terraform**
Create a Terraform configuration file (`main.tf`) for an AWS EC2 instance:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"  # Example AMI ID for Amazon Linux 2
  instance_type = "t2.micro"
  tags = {
    Name = "WebServer"
  }
}
```

### **Step 2: Apply the Configuration**
Initialize and apply the configuration:

```bash
terraform init
terraform apply -auto-approve
```

### **Step 3: Mark the EC2 Instance as Tainted**
Suppose we want to force the replacement of the EC2 instance:

```bash
terraform taint aws_instance.web
```

Now, if we run `terraform plan`, Terraform will show that the instance will be destroyed and recreated.

### **Step 4: Remove the Taint**
If you decide **not** to replace the instance, run:

```bash
terraform untaint aws_instance.web
```

This command removes the tainted status, so when you run `terraform apply`, Terraform will **not** recreate the instance.

---

## **Verification**
After running `terraform untaint`, check the plan:

```bash
terraform plan
```
- If `untaint` was successful, Terraform will show **no changes** needed.

---

