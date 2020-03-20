terraform {
  backend "s3" {
    access_key     = "${rb_user_access_key}"
    secret_key     = "${rb_user_secret_key}"
    encrypt        = true
    bucket         = "${rb_s3_bucket_name}"
    dynamodb_table = "${rb_dynamodb_table_name}"
    region         = "${rb_aws_region}"
    key            = "${rb_path_to_tfstate}"
  }
}