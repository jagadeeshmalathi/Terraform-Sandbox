data "aws_caller_identity" "current" {}

# KMS KEY
resource "aws_kms_key" "audit_logs" {
  description             = "KMS key for S3 audit logs"
  deletion_window_in_days = 30

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "RootAccess",
      "Effect": "Allow",
      "Principal": {
        "AWS": "arn:aws:iam::${data.aws_caller_identity.current.account_id}:root"
      },
      "Action": "kms:*",
      "Resource": "*"
    },
    {
      "Sid": "AllowS3Usage",
      "Effect": "Allow",
      "Principal": {
        "Service": "s3.amazonaws.com"
      },
      "Action": [
        "kms:Encrypt",
        "kms:Decrypt",
        "kms:GenerateDataKey*",
        "kms:DescribeKey"
      ],
      "Resource": "*",
      "Condition": {
        "StringEquals": {
          "kms:ViaService": "s3.${var.aws_region}.amazonaws.com"
        }
      }
    }
  ]
}
EOF

  tags = var.tags
}

resource "aws_kms_alias" "audit_logs_alias" {
  name          = "alias/s3-audit-logs"
  target_key_id = aws_kms_key.audit_logs.key_id
}

# S3 BUCKET
resource "aws_s3_bucket" "audit_logs" {
  bucket = var.bucket_name
  acl    = "private"

  tags = merge(var.tags, { Name = var.bucket_name })
}

# Block all public access
resource "aws_s3_bucket_public_access_block" "block_public" {
  bucket                  = aws_s3_bucket.audit_logs.id
  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning
resource "aws_s3_bucket_versioning" "versioning" {
  bucket = aws_s3_bucket.audit_logs.id

  versioning_configuration {
    status = "Enabled"
  }
}

# Server-side encryption using KMS
resource "aws_s3_bucket_server_side_encryption_configuration" "encryption" {
  bucket = aws_s3_bucket.audit_logs.id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = "aws:kms"
      kms_master_key_id = aws_kms_key.audit_logs.arn
    }
  }
}

# Lifecycle policy
resource "aws_s3_bucket_lifecycle_configuration" "lifecycle" {
  bucket = aws_s3_bucket.audit_logs.id

  rule {
    id     = "move-to-standard-ia"
    status = "Enabled"

    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }

    noncurrent_version_transition {
      noncurrent_days = 30
      storage_class   = "STANDARD_IA"
    }
  }
}