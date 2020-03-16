# S3 Bucket to hold terraform state
resource "aws_s3_bucket" "terraform-state-storage-s3" {
  bucket = var.bucket_name
  versioning {
    enabled = var.bucket_versioning
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "Terraform state store on S3"
  }
}

# DynamoDB table to store state lock
resource "aws_dynamodb_table" "dynamodb-terraform-state-lock" {
  name           = var.dynamodb_table_name
  hash_key       = "LockID"
  read_capacity  = 20
  write_capacity = 20
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    Name = "Terraform state lock on DynamoDB"
  }
}