provider "aws" {
  region     = var.region
  access_key = ""
  secret_key = ""
}


#create bucket
resource "aws_s3_bucket" "myredbus-bucket" {
  bucket = "myredbus-bucket001"
  
    
  tags = {
    Name = "myredbus-bucket001"
  }
}

resource "aws_s3_bucket_versioning" "versioning_myredbus" {
  bucket = aws_s3_bucket.myredbus-bucket.id
  versioning_configuration {
      status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "myredbus_bucket_public_access" {
  bucket = aws_s3_bucket.myredbus-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}
