// AWS region
variable "aws_region" {
  description = "AWS region"
  default = "eu-west-1"
}

// Name of AWS user
variable "aws_user_name" {
  description = "User to be created that will be responsible for managing remote backend"
}
// Name of S3 Bucket
variable "bucket_name" {
  description = "S3 bucket that will be used to store terraform state, value should be unique"
  default     = "terraform-state-store-w3qrt"
}

// Enable versioning
variable "bucket_versioning" {
  description = "Enable S3 bucket versioning"
  default = true
}

// Name of DynamoDB Table
variable "dynamodb_table_name" {
  description = "DynamoDB table that will be used to store state lock, value should be unique"
  default     = "terraform-state-lock-w3qrt"
}

// Path to tfstate file
variable "path_to_tfstate" {
  description = "Path to tfstate file"
  default     = "terraform.tfstate"
}