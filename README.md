# tf-atom-s3-bucket-encryption-aws

[![CI](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-encryption-aws/actions/workflows/ci.yml/badge.svg)](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-encryption-aws/actions/workflows/ci.yml)
[![Release](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-encryption-aws/actions/workflows/auto-release.yml/badge.svg)](https://github.com/PlatformStackPulse/tf-atom-s3-bucket-encryption-aws/actions/workflows/auto-release.yml)

---

## Purpose

Configures default server-side encryption for an S3 bucket. Supports AWS-managed KMS keys, customer-managed KMS keys, and AES-256 encryption. Bucket Key is enabled by default to reduce KMS API costs.

## Architecture

```
┌─────────────────────────────────────────────────────┐
│           Molecule Layer                            │
│  ┌──────────────┐    ┌──────────────────────┐      │
│  │ s3-bucket    │───▶│ THIS MODULE          │      │
│  │ (bucket_id)  │    │ encryption-config    │      │
│  └──────────────┘    │ (SSE-KMS or AES256)  │      │
│                      └──────────────────────┘      │
│  ┌──────────────┐              ▲                   │
│  │ KMS Key      │──────────────┘ (optional CMK)    │
│  │ (external)   │                                  │
│  └──────────────┘                                  │
└─────────────────────────────────────────────────────┘
```

## Scope

| In Scope | Out of Scope |
|----------|--------------|
| `aws_s3_bucket_server_side_encryption_configuration` | Bucket creation (→ `tf-atom-s3-bucket-aws`) |
| SSE-KMS, SSE-KMS:DSSE, AES256 algorithms | KMS key creation (→ `tf-atom-kms-key-aws`) |
| Bucket Key optimization | Object-level encryption overrides |
| Optional CMK reference | Key rotation policies |

## Features

- **Single-resource atom** — one `aws_s3_bucket_server_side_encryption_configuration`
- **KMS by default** — uses `aws:kms` with AWS-managed key out of the box
- **Bucket Key enabled** — reduces KMS API costs by default
- **CMK support** — pass `kms_master_key_id` for customer-managed keys
- **Validation** — enforces valid algorithm values
- **Tested** — unit tests for KMS default, AES256, and disabled scenarios

## Usage

```hcl
module "bucket_encryption" {
  source = "github.com/PlatformStackPulse/tf-atom-s3-bucket-encryption-aws?ref=v1.0.0"

  context   = module.this.context
  bucket_id = module.bucket.bucket_id

  # Defaults: aws:kms with bucket key enabled
  # sse_algorithm     = "aws:kms"
  # kms_master_key_id = null  # Uses aws/s3 managed key
  # bucket_key_enabled = true
}
```

## Module Documentation

<!-- BEGIN_TF_DOCS -->
<!-- END_TF_DOCS -->
