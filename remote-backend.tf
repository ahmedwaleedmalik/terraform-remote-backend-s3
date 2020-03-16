# Note: Variables are not allowed in backend config
terraform {
  backend "s3" {
    access_key     = "<concealed>"
    secret_key     = "<concealed>"
    encrypt        = true
    bucket         = "terraform-state-store-w3qrt"
    dynamodb_table = "terraform-state-lock-w3qrt"
    region         = "eu-west-1"
    key            = "terraform.tfstate"
  }
}