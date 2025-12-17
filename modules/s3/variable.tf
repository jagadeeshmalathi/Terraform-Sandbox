variable "bucket_name" {
  type        = string
  description = "S3 bucket name for audit logs"
}

variable "aws_region" {
  type = string
}

variable "tags" {
  type = map(string)
  default = {
    Purpose = "audit-logs"
    Managed = "terraform"
  }
}