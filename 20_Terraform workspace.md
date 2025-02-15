### **Terraform Workspace Command**

Terraform workspaces allow you to manage multiple environments (e.g., **development, staging, production**) within the same Terraform configuration. They provide a way to maintain different states for different environments without creating separate directories or repositories.

By default, Terraform starts with a workspace named **"default"**. You can create, switch, and list workspaces using `terraform workspace` commands.

### **Terraform Workspace Commands**
Here are the commonly used `terraform workspace` commands:

1. **List all workspaces**
   ```sh
   terraform workspace list
   ```
   Shows all available workspaces in the current working directory.

2. **Create a new workspace**
   ```sh
   terraform workspace new <workspace_name>
   ```
   Creates a new workspace.

3. **Switch to a workspace**
   ```sh
   terraform workspace select <workspace_name>
   ```
   Switches to an existing workspace.

4. **Show the current workspace**
   ```sh
   terraform workspace show
   ```
   Displays the current active workspace.

5. **Delete a workspace**
   ```sh
   terraform workspace delete <workspace_name>
   ```
   Deletes an existing workspace (you cannot delete the **default** workspace).

---

## **Example: Using Terraform Workspaces in AWS**

### **Scenario**
We will use Terraform workspaces to manage different environments (`dev`, `staging`, `prod`) for an **AWS EC2 instance**.

### **1. Initialize Terraform**
```sh
terraform init
```

### **2. Create Workspaces**
```sh
terraform workspace new dev
terraform workspace new staging
terraform workspace new prod
```

### **3. Define Terraform Configuration (`main.tf`)**
Create a `main.tf` file for an AWS EC2 instance that uses the workspace name dynamically.

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0" # Update with your AMI
  instance_type = var.instance_type

  tags = {
    Name = "web-${terraform.workspace}" # Naming instance based on workspace
    Environment = terraform.workspace
  }
}

variable "instance_type" {
  default = "t2.micro"

  # Different instance types for different environments
  type = map(string)
  default = {
    default = "t2.micro"
    dev     = "t2.small"
    staging = "t2.medium"
    prod    = "t2.large"
  }
}

output "workspace" {
  value = terraform.workspace
}

output "instance_type" {
  value = lookup(var.instance_type, terraform.workspace, "t2.micro")
}
```

### **4. Apply Changes Based on Workspace**
#### **Switch to Dev Environment and Apply**
```sh
terraform workspace select dev
terraform apply -auto-approve
```
- Deploys an EC2 instance with type **t2.small**.

#### **Switch to Staging Environment and Apply**
```sh
terraform workspace select staging
terraform apply -auto-approve
```
- Deploys an EC2 instance with type **t2.medium**.

#### **Switch to Production Environment and Apply**
```sh
terraform workspace select prod
terraform apply -auto-approve
```
- Deploys an EC2 instance with type **t2.large**.

### **5. Verify Workspaces**
```sh
terraform workspace list
terraform workspace show
```

### **6. Destroy Resources in a Workspace**
To delete resources for a specific workspace:
```sh
terraform destroy -auto-approve
```
To delete a workspace (make sure it’s empty):
```sh
terraform workspace select default
terraform workspace delete dev
```

---

### **Summary**
✅ Terraform workspaces allow managing multiple environments using the same configuration.  
✅ They store separate Terraform state files per workspace.  
✅ Using `terraform.workspace`, we can create dynamic resource configurations.  
✅ Workspaces help in isolating environments like `dev`, `staging`, and `prod`.

