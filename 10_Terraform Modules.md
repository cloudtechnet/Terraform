### **Terraform Modules Command**

#### **What are Terraform Modules?**
Terraform modules are reusable, self-contained configurations that help organize infrastructure as code (IaC). They allow you to break down complex configurations into manageable and reusable components.

#### **Terraform `module` Command**
Terraform provides the `terraform module` command to interact with modules. The primary commands include:

- `terraform get`: Downloads and installs modules listed in the configuration.
- `terraform init`: Initializes a module by downloading required providers and dependencies.
- `terraform apply`: Deploys infrastructure using modules.
- `terraform destroy`: Deletes infrastructure managed by modules.
- `terraform output`: Displays module outputs.

---

## **Example: Using a Terraform Module to Deploy an AWS EC2 Instance**
Let's create a reusable module for provisioning an AWS EC2 instance.

### **Step 1: Create a Module**
Create a folder structure:

```
terraform-aws-ec2/
│── main.tf
│── variables.tf
│── outputs.tf
│── modules/
│   ├── ec2-instance/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
```

### **Step 2: Define the EC2 Module (modules/ec2-instance/main.tf)**

```hcl
provider "aws" {
  region = var.aws_region
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
```

### **Step 3: Define Variables for the Module (modules/ec2-instance/variables.tf)**
```hcl
variable "aws_region" {}
variable "ami_id" {}
variable "instance_type" {}
variable "instance_name" {}
```

### **Step 4: Define Outputs for the Module (modules/ec2-instance/outputs.tf)**
```hcl
output "instance_id" {
  value = aws_instance.example.id
}
```

---

## **Step 5: Use the Module in `main.tf`**
```hcl
module "ec2_instance" {
  source        = "./modules/ec2-instance"
  aws_region    = "us-east-1"
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  instance_name = "MyTerraformInstance"
}

output "ec2_id" {
  value = module.ec2_instance.instance_id
}
```

---

## **Step 6: Initialize and Apply Terraform**
Run the following commands:
```sh
terraform init
terraform apply -auto-approve
```

### **Step 7: Verify Outputs**
After successful deployment, you should see:
```sh
Outputs:
ec2_id = "i-0abcd1234efgh5678"
```

---

## **Step 8: Destroy Infrastructure**
To delete the EC2 instance:
```sh
terraform destroy -auto-approve
```

---

## **Key Benefits of Using Modules**
- **Reusability**: Modules allow code reuse across multiple projects.
- **Maintainability**: Easier to manage and update configurations.
- **Scalability**: Helps structure large infrastructure codebases efficiently.

