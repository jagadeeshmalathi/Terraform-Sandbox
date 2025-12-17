output "ec2_public_ips" {
  value = module.my_ec2.public_ip
}

output "ec2_private_ips" {
  value = module.my_ec2.private_ip
}

output "audit_bucket_name" {
  value = module.s3_audit_logs.bucket_name
}

output "kms_key_arn" {
  value = module.s3_audit_logs.kms_key_arn
}