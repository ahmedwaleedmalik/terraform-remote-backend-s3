# terraform-remote-backend-s3
A terraform module to provision remote backend on s3. It will create `S3 bucket` for storing terraform state, `dynamoDB table` 
for maintaining lock on terraform state and a restricted `user` that will only have access to the S3 bucket and dynamoDB table.


# Pre-requisites

1. An AWS user with following Policies attached `IAMFullAccess`, `AmazonS3FullAccess` and `AmazonDynamoDBFullAccess`, 
required to create a user, S3 bucket and a dynamoDB table.

# Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| aws_user_name | Name of user to be created| string | - | yes |
| bucket_name | Name of the S3 bucket for state storage| string | - | yes |
| bucket_versioning | Enable bucket versioning | boolean | true | yes |
| dynamodb_table_name | Name of dynamoDB table for state lock| string | - | yes |
| path_to_tfstate | Path to terraform.tfstate file| string | terraform.tfstate | yes |
| aws_region | Region for AWS| string | eu-west-1 | yes |

*NOTE:* bucket_name and dynamodb_table_name must should be unique

# Usage

```hcl
module "terraform_remote_backend" {
  source = "github.com/ahmedwaleedmalik/terraform-remote-backend-s3?ref=v1.0.0"

  aws_region = "eu-west-1"
  aws_user_name = "terraform-state-user"
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