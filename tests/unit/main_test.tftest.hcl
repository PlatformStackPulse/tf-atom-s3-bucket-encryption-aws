mock_provider "aws" {}

run "defaults_to_kms_encryption" {
  variables {
    name        = "test"
    environment = "dev"
    namespace   = "unit"
    bucket_id   = "my-test-bucket"
  }

  assert {
    condition     = output.sse_algorithm == "aws:kms"
    error_message = "Should default to aws:kms encryption"
  }

  assert {
    condition     = output.id != null
    error_message = "id output should not be null when enabled"
  }
}

run "creates_nothing_when_disabled" {
  variables {
    name        = "test"
    environment = "dev"
    namespace   = "unit"
    enabled     = false
    bucket_id   = "my-test-bucket"
  }

  assert {
    condition     = length(aws_s3_bucket_server_side_encryption_configuration.this) == 0
    error_message = "No resource should be created when disabled"
  }
}

run "supports_aes256" {
  variables {
    name          = "test"
    environment   = "dev"
    namespace     = "unit"
    bucket_id     = "my-test-bucket"
    sse_algorithm = "AES256"
  }

  assert {
    condition     = output.sse_algorithm == "AES256"
    error_message = "Should support AES256 algorithm"
  }
}
