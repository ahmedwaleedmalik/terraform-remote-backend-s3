# terraform-remote-backend-s3
A concise example of setting up remote backend on s3 for terraform.

# Pre-requisites

1. Create a user with following Policies attached `AmazonS3FullAccess` and `AmazonDynamoDBFullAccess`, for demonstration purposes
2. Pass credentials in provider.tf

# Usage

1. Run `terraform init`, followed by `terraform plan` to review the changes required to meet desired state and 
`terraform apply` to apply those changes.
2. It will output a file `remote-backend.tf` this can be used to remotely manage terraform state
3. Copy this file to a repository where you want to use remote backend. Run `terraform init` for terraform to detect and
 install relevant plugins and start using remote backend for state

# Useful Resources

- https://blog.gruntwork.io/terraform-up-running-2nd-edition-early-release-is-now-available-b104fc29783f
- https://www.terraform.io/docs/backends/types/s3.html