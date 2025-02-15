### **`terraform test` Command**

The `terraform test` command is used to run tests on Terraform modules using the **Terraform test framework**. It ensures that your Terraform configurations behave as expected before applying them to production.

#### **Key Features:**
1. **Validates module outputs** - Ensures that outputs meet specific conditions.
2. **Executes in an isolated environment** - Uses **plan-time testing** to verify Terraform behavior.
3. **Prevents costly mistakes** - Catches misconfigurations before deploying resources.

#### **Terraform Testing Framework**
- Terraform tests are written in **HCL (HashiCorp Configuration Language)**.
- They reside inside a **`tests`** directory in a Terraform module.
- Tests use the **`assert` block** to validate outputs.

---

## **Example: Testing an AWS EC2 Module**
Let's test an AWS EC2 instance Terraform module using the `terraform test` command.

### **Step 1: Create Terraform Module (`main.tf`)**
This module provisions an EC2 instance.

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Amazon Linux 2 AMI ID
  instance_type = "t2.micro"

  tags = {
    Name = "TestInstance"
  }
}

output "instance_type" {
  value = aws_instance.example.instance_type
}
```

---

### **Step 2: Create a Test File (`tests/ec2_test.tf`)**
Terraform test cases are written in a separate `tests/` folder.

```hcl
test {
  name = "EC2_Instance_Type_Validation"

  # Apply the module in an isolated test environment
  run "terraform plan -out=tfplan"

  assert {
    condition     = terraform.output.instance_type == "t2.micro"
    error_message = "Instance type is not t2.micro!"
  }
}
```

---

### **Step 3: Run the Terraform Test**
Execute the test with:

```sh
terraform test
```

---

### **Step 4: Expected Output**
If the test passes, you'll see:

```plaintext
Running test EC2_Instance_Type_Validation...
Test passed.
```

If it fails, an error message appears:

```plaintext
Test EC2_Instance_Type_Validation failed:
Instance type is not t2.micro!
```

