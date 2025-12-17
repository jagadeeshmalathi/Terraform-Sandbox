output "bucket_name" {
  value = aws_s3_bucket.audit_logs.bucket
}

output "bucket_arn" {
  value = aws_s3_bucket.audit_logs.arn
}

output "kms_key_arn" {
  value = aws_kms_key.audit_logs.arn
}