// arn of user that we created
output "user_arn" {
  value = "${aws_iam_user.user.arn}"
}

// Access key
output "iam_access_key_id" {
  value = "${aws_iam_access_key.user_keys.id}"
}

// Access key secret
output "iam_access_key_secret" {
  value = "${aws_iam_access_key.user_keys.secret}"
}