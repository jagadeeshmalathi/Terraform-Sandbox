AWS S3 Audit Logs Terraform Deployment (Module-Based)

This Terraform project provisions a secure AWS S3 bucket for storing sensitive application audit logs using a modular Terraform design.

The solution enforces security best practices such as private access, encryption at rest, versioning, and lifecycle management, making it suitable for compliance and audit use cases.

Project Structure

modules/s3-audit-logs/

main.tf — Contains resource definitions for the S3 bucket, encryption, versioning, and lifecycle rules.

variables.tf — Contains input variables required by the S3 audit logs module.

outputs.tf — Exposes module outputs such as bucket name and KMS key ARN.

modules.tf — Root module that calls the reusable S3 audit logs module.

provider.tf — AWS provider configuration.

output.tf — Root-level outputs.

README.md — Project documentation.

Resources Created

S3 Bucket:
A private S3 bucket used to store application audit logs.

Public Access Block:
Blocks all public access via ACLs and bucket policies.

S3 Bucket Versioning:
Enables versioning to protect against accidental object deletion or overwrite.

Server-Side Encryption:
Encrypts all objects at rest using AWS KMS.

S3 Lifecycle Policy:
Automatically transitions objects and non-current object versions to STANDARD_IA after 30 days to reduce storage costs.

Variables

Input variables are defined in variables.tf. Typical variables include:

Variable Name	Description	Required
bucket_name	Globally unique S3 bucket name	Yes
aws_region	AWS region for resource deployment	Yes

Variables can be overridden by passing values via the CLI or by using a terraform.tfvars file.

Example usage:

terraform plan -var="bucket_name=my-audit-logs-bucket-123"