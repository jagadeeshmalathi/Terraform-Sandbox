resource "aws_s3_bucket" "application_audit_logs" {  
  bucket = "unique-audit-log-bucket-${random_id.bucket_suffix.hex}"
  tags = {
    Name        = "Application-Audit-Logs"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket_acl" "application_audit_logs_acl" {
  bucket = aws_s3_bucket.application_audit_logs.id 
  acl    = "private"
}

resource "aws_s3_bucket_versioning" "versioning_application_audit_logs" {
  bucket = aws_s3_bucket.application_audit_logs.id 
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "audit_logs" {
  bucket = aws_s3_bucket.application_audit_logs.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true

  depends_on = [aws_s3_bucket.application_audit_logs] 
}

resource "aws_kms_key" "audit_logs" {
  description             = "KMS key for audit logs S3 bucket encryption"
  enable_key_rotation     = true
  deletion_window_in_days = 7

  policy = jsonencode({ 
    Statement = [{
      Sid    = "Allow S3"
      Effect = "Allow"
      Principal = {
        AWS = "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      }
      Action   = "kms:*"
      Resource = "*"
    }]
  })
}

data "aws_caller_identity" "current" {}  

resource "aws_s3_bucket_server_side_encryption_configuration" "audit_logs_encryption" {
  bucket = aws_s3_bucket.application_audit_logs.bucket

  rule {
    apply_server_side_encryption_by_default {
      kms_master_key_id = aws_kms_key.audit_logs.arn
      sse_algorithm     = "aws:kms"
    }
  }
  depends_on = [aws_s3_bucket.application_audit_logs]
}

resource "aws_s3_bucket_lifecycle_configuration" "bucket-config" {
  bucket = aws_s3_bucket.application_audit_logs.id  

  rule {
    id = "audit-log-cleanup"

    filter {
      and {
        prefix = "log/"
        tags = {
          rule      = "log"
          autoclean = "true"
        }
      }
    }

    status = "Enabled"  
    expiration {
      days = 90  
    }

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_expiration {
      noncurrent_days = 30
    }
  }
}