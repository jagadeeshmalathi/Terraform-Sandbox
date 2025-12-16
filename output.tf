output "audit_bucket_name" {
  value = module.s3_audit_logs.bucket_name
}

output "kms_key_arn" {
  value = module.s3_audit_logs.kms_key_arn
}