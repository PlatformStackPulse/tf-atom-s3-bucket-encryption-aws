variable "bucket_id" {
  description = "ID (name) of the S3 bucket to configure encryption for"
  type        = string
}

variable "sse_algorithm" {
  description = "Server-side encryption algorithm (aws:kms, aws:kms:dsse, or AES256)"
  type        = string
  default     = "aws:kms"

  validation {
    condition     = contains(["aws:kms", "aws:kms:dsse", "AES256"], var.sse_algorithm)
    error_message = "sse_algorithm must be one of: aws:kms, aws:kms:dsse, AES256"
  }
}

variable "kms_master_key_id" {
  description = "KMS key ARN or ID for encryption. If null, uses AWS-managed key (aws/s3)"
  type        = string
  default     = null
}

variable "bucket_key_enabled" {
  description = "Whether to use S3 Bucket Key for SSE-KMS (reduces KMS costs)"
  type        = bool
  default     = true
}
