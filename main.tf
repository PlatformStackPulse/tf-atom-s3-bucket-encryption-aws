# -----------------------------------------------------
# Atom: S3 Bucket Server-Side Encryption Configuration
# Configures default encryption for an S3 bucket.
# -----------------------------------------------------
resource "aws_s3_bucket_server_side_encryption_configuration" "this" {
  count = module.this.enabled ? 1 : 0

  bucket = var.bucket_id

  rule {
    apply_server_side_encryption_by_default {
      sse_algorithm     = var.sse_algorithm
      kms_master_key_id = var.kms_master_key_id
    }
    bucket_key_enabled = var.bucket_key_enabled
  }
}
