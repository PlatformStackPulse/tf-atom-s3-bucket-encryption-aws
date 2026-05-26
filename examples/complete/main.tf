provider "aws" {
  region = "eu-west-2"
}

module "s3_encryption" {
  source = "../../"

  namespace   = "psp"
  environment = "dev"
  name        = "assets"

  bucket_id         = "psp-dev-assets"
  sse_algorithm     = "aws:kms"
  bucket_key_enabled = true
  # kms_master_key_id = aws_kms_key.my_key.arn  # Optional: CMK
}

output "id" {
  value = module.s3_encryption.id
}
