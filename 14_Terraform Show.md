### **Terraform `show`**

The `terraform show` command is used to display the Terraform state or a saved plan in a human-readable format. This helps in understanding what resources exist in the Terraform state and what changes will be applied.

### **Syntax**
```sh
terraform show [options] [PATH]
```
- Without arguments: Displays the current Terraform state.
- With a file argument (like `terraform.plan`): Shows the details of a saved plan.

### **Use Cases**
1. Inspect the current state of managed resources.
2. Review the details of a Terraform execution plan.
3. Debug and validate Terraform state files.

---

### **Example: Using `terraform show` with AWS**

#### **Step 1: Create an AWS EC2 Instance Using Terraform**
First, create a simple Terraform configuration file (`main.tf`):

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "TerraformShowExample"
  }
}
```

#### **Step 2: Initialize Terraform**
Run:
```sh
terraform init
```
This initializes the Terraform working directory.

#### **Step 3: Apply Terraform Plan**
Run:
```sh
terraform apply -auto-approve
```
This provisions the AWS EC2 instance.

#### **Step 4: Use `terraform show` to View the State**
Run:
```sh
terraform show
```

**Example Output:**
```hcl
# aws_instance.web:
resource "aws_instance" "web" {
    ami                                  = "ami-0c55b159cbfafe1f0"
    arn                                  = "arn:aws:ec2:us-east-1:123456789012:instance/i-0123456789abcdef0"
    instance_type                        = "t2.micro"
    availability_zone                    = "us-east-1a"
    private_ip                           = "192.168.1.1"
    public_ip                            = "3.95.200.150"
    tags = {
        "Name" = "TerraformShowExample"
    }
}
```

This output displays all the attributes of the provisioned EC2 instance.

---

### **Alternative: Using `terraform show` with a Plan File**
If you generate a plan file:
```sh
terraform plan -out=tfplan
```
You can inspect the changes before applying:
```sh
terraform show tfplan
```

