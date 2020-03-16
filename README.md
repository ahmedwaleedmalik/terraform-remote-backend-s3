# terraform-remote-backend-s3
A concise example of setting up remote backend on s3 for terraform.

# Pre-requisites

1. Create a user with following Policies attached `AmazonS3FullAccess` and `AmazonDynamoDBFullAccess`, for demonstration purposes
2. Pass credentials in provider.tf and remote-backend.tf

# To use

Run `terraform init`, followed by `terraform plan` to review the changes required to meet desired state and 
`terraform apply` to apply those changes.