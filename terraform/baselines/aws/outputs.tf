# terraform/baselines/aws/outputs.tf
output "trail_name" {
  value       = aws_cloudtrail.mgmt.name
  description = "CloudTrail name for verify commands."
}

output "trail_bucket" {
  value       = aws_s3_bucket.trail.id
  description = "S3 bucket receiving CloudTrail logs."
}

output "securityhub_account_id" {
  value       = aws_securityhub_account.this.id
  description = "Account ID Security Hub is enabled in (also the terraform import id)."
}
