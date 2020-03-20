# terraform-remote-backend-s3
A concise example of setting up remote backend on s3 for terraform.

# Pre-requisites

1. An AWS user with following Policies attached `IAMFullAccess`, `AmazonS3FullAccess` and `AmazonDynamoDBFullAccess`, 
required to create a user, S3 bucket and a dynamoDB table.

# Usage

```hcl
module "terraform_remote_backend" {
  source = "github.com/ahmedwaleedmalik/terraform-remote-backend-s3?ref=master"

  aws_region = "eu-west-1"
  bucket_name = "terraform-state-store"
  bucket_versioning = true
  dynamodb_table_name = "terraform-state-lock"
  path_to_tfstate = "terraform.tfstate"
}
```

1. Run `terraform init`, followed by `terraform plan` to review the changes required to meet desired state and 
`terraform apply` to apply those changes.
2. It will output a file `remote-backend.tf` this can be used to remotely manage terraform state
3. Run `terraform init`(mandatory) for terraform to detect and install relevant plugins and start using remote backend for state

# Useful Resources

- https://blog.gruntwork.io/terraform-up-running-2nd-edition-early-release-is-now-available-b104fc29783f
- https://www.terraform.io/docs/backends/types/s3.html