output "enabled" {
  description = "Whether the module is enabled."
  value       = local.enabled
}

output "id" {
  description = "ID of the encryption configuration"
  value       = try(aws_s3_bucket_server_side_encryption_configuration.this[0].id, null)
}

output "sse_algorithm" {
  description = "The encryption algorithm in use"
  value       = var.sse_algorithm
}
