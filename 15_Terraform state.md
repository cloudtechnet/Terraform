### **Terraform `state` Command**

The `terraform state` command is used to manage Terraform's state file. Terraform maintains a state file to keep track of infrastructure resources it manages. The `state` command allows you to inspect, modify, and manipulate this state file.

### **Common Terraform `state` Commands**
1. **`terraform state list`** – Lists all resources in the state file.
2. **`terraform state show <resource>`** – Shows detailed information about a specific resource.
3. **`terraform state pull`** – Retrieves the current state and outputs it in JSON format.
4. **`terraform state mv <source> <destination>`** – Moves a resource within the state.
5. **`terraform state rm <resource>`** – Removes a resource from the state file (Terraform will not manage it anymore).
6. **`terraform state replace-provider <old-provider> <new-provider>`** – Replaces provider references in the state.

---

### **Example: Managing AWS State with Terraform**
Let's say we are managing an **AWS EC2 instance** with Terraform.

#### **Step 1: Create a Terraform Configuration for AWS EC2**
```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "web" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "Terraform-EC2"
  }
}
```
Run:
```sh
terraform init
terraform apply -auto-approve
```
Now Terraform creates an EC2 instance and stores it in the **state file**.

---

### **Using Terraform State Commands**
#### **1. List all resources in the state file**
```sh
terraform state list
```
**Output:**
```
aws_instance.web
```
This shows that Terraform is managing the `aws_instance.web` resource.

---

#### **2. Show details of a specific resource**
```sh
terraform state show aws_instance.web
```
**Output (Example):**
```
# aws_instance.web:
resource "aws_instance" "web" {
    ami                          = "ami-0c55b159cbfafe1f0"
    instance_type                = "t2.micro"
    id                           = "i-0abcd1234efgh5678"
    availability_zone            = "us-east-1a"
    private_ip                   = "192.168.1.100"
    public_ip                    = "54.123.45.67"
    tags = {
        Name = "Terraform-EC2"
    }
}
```
This provides detailed information about the EC2 instance.

---

#### **3. Move a resource in the state file**
Suppose you want to rename `aws_instance.web` to `aws_instance.new_web` in Terraform without re-creating the instance.

```sh
terraform state mv aws_instance.web aws_instance.new_web
```
This updates the state file to use the new name.

---

#### **4. Remove a resource from Terraform state**
If you no longer want Terraform to manage the EC2 instance but don’t want to delete it from AWS, you can remove it from the state file:

```sh
terraform state rm aws_instance.web
```
Now Terraform will no longer track this EC2 instance.

---

#### **5. Pull the state file**
You can view the raw state file using:

```sh
terraform state pull
```
This returns a JSON representation of the state.

