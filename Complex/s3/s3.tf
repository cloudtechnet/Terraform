# s3/s3.tf
resource "aws_s3_bucket" "main" {
  bucket = var.bucket_name

  tags = {
    Name = "main-bucket"
  }
}
