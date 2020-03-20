# User that will only be able to access s3 bucket and dynamoDB table
resource "aws_iam_user" "user" {
  name = "user_${var.bucket_name}"
}

# Access/Secret key for user
resource "aws_iam_access_key" "user_keys" {
  user = "${aws_iam_user.user.name}"
}

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

# Creating policies for the user.
resource "aws_iam_policy" "user_policy" {
  name   = "RemoteBackendAccessPolicy"
  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:ListBucket"
      ],
      "Resource": [
        "${aws_s3_bucket.terraform-state-storage-s3.arn}",
        "${aws_s3_bucket.terraform-state-storage-s3.arn}/*"
      ]
    }
    {
      "Effect": "Allow",
      "Action": [
        "dynamodb:GetItem",
        "dynamodb:PutItem",
        "dynamodb:DeleteItem"
      ],
      "Resource": [
        "${aws_dynamodb_table.dynamodb-terraform-state-lock.arn}",
        "${aws_dynamodb_table.dynamodb-terraform-state-lock.arn}/*"
      ]
    }
  ]
}
EOF
}

# Attaching the policies with the user.
resource "aws_iam_user_policy_attachment" "user_policy_attachment" {
  user       = "${aws_iam_user.user.name}"
  policy_arn = "${aws_iam_policy.user_policy.arn}"
}

# Create remote backend resource from template
data "template_file" "remote_backend" {
  template = file("${path.module}/templates/remote-backend.tf.tpl")

  vars = {
    rb_user_access_key     = aws_iam_access_key.user_keys.id
    rb_user_secret_key     = aws_iam_access_key.user_keys.secret
    rb_s3_bucket_name      = aws_s3_bucket.terraform-state-storage-s3.id
    rb_dynamodb_table_name = aws_dynamodb_table.dynamodb-terraform-state-lock.name
    rb_aws_region          = var.aws_region
    rb_path_to_tfstate     = var.path_to_tfstate
  }
}

# Write the output file `remote-backend.tf`
resource "null_resource" "export_rendered_template" {
  provisioner "local-exec" {
    command = "cat > remote-backend.tf <<EOL\n${join(",\n", data.template_file.remote_backend.*.rendered)}\nEOL"
  }
}
