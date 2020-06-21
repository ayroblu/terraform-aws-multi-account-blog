provider "aws" {
  region = "eu-west-2"
}

# https://medium.com/@jessgreb01/how-to-terraform-locking-state-in-s3-2dc9a5665cb6
resource aws_s3_bucket backend {
  bucket = "<bucket-name>"
  acl    = "private"

  versioning {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }

  tags = {
    Name = "S3 Remote Terraform State Store"
  }
}

# 25GB, 25 read, 25 write for free tier
resource aws_dynamodb_table terraform-state-lock {
  name           = "terraform-state-lock"
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "DynamoDB Terraform State Lock Table"
  }
}
