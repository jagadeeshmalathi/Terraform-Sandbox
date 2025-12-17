module "s3_audit_logs"{
 source = "../../modules/s3-audit-logs"
 bucket_name = var.bucket_name
 aws_region  = var.aws_region
}