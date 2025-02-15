### **Terraform `version` Command**

The `terraform version` command is used to display the currently installed Terraform version along with additional details like the underlying architecture and any installed provider versions.

### **Syntax**
```sh
terraform version
```

### **Output Example**
```sh
Terraform v1.6.0
on linux_amd64
```
If you have provider plugins installed, the output will also show them:
```sh
Terraform v1.6.0
on linux_amd64

Your version of Terraform is out of date! The latest version is 1.7.0.
```

## **Example: Using Terraform with AWS**
Let's go through an example where we use Terraform to set up an AWS EC2 instance and check the Terraform version.

### **1. Check Terraform Version**
Before running Terraform commands, verify the installed version:
```sh
terraform version
```

### **2. Create a Terraform Configuration File**
Create a new file called `main.tf` with the following content:

```hcl
terraform {
  required_version = ">= 1.3.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
}
```

### **3. Initialize Terraform**
Run the following command to download the required provider plugins:
```sh
terraform init
```

### **4. Apply the Configuration**
```sh
terraform apply
```
This will prompt for confirmation before creating the AWS EC2 instance.

### **5. Verify Version Again**
After applying changes, you can check the Terraform version again:
```sh
terraform version
```
