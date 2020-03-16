# terraform-remote-backend-s3
A concise example of setting up remote backend on s3 for terraform.

# Pre-requisites

1. Create a user with following Policies attached `AmazonS3FullAccess` and `AmazonDynamoDBFullAccess`, for demonstration purposes
2. Pass credentials in provider.tf and remote-backend.tf

# Usage

Run `terraform init`, followed by `terraform plan` to review the changes required to meet desired state and 
`terraform apply` to apply those changes.

# TODO

1. Create new user at end that only has access to the created s3 bucket and dynamoDB table and use that in `remote-backend.tf`

# Useful Resources

- https://blog.gruntwork.io/terraform-up-running-2nd-edition-early-release-is-now-available-b104fc29783f
- https://www.terraform.io/docs/backends/types/s3.html