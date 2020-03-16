// Name of S3 Bucket
variable "bucket_name" {
  default = "terraform-state-store-w3qrt"
}

// Enable versioning
variable "bucket_versioning" {
  default = true
}

// Name of DynamoDB Table
variable "dynamodb_table_name" {
  default = "terraform-state-lock-w3qrt"
}