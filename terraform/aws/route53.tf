resource "aws_kms_key" "domaindnssec" {
  customer_master_key_spec = "ECC_NIST_P256"
  deletion_window_in_days  = 7
  key_usage                = "SIGN_VERIFY"
  policy = jsonencode({
    Statement = [
      {
        Action = [
          "kms:DescribeKey",
          "kms:GetPublicKey",
          "kms:Sign",
          "kms:Verify",
        ],
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Resource = "*"
        Sid      = "Allow Route 53 DNSSEC Service",
      },
      {
        Action = "kms:CreateGrant",
        Effect = "Allow"
        Principal = {
          Service = "dnssec-route53.amazonaws.com"
        }
        Sid      = "Allow Route 53 DNSSEC Service to CreateGrant",
        Resource = "*"
        Condition = {
          Bool = {
            "kms:GrantIsForAWSResource" = "true"
          }
        }
      },
      {
        Action = "kms:*"
        Effect = "Allow"
        Principal = {
          AWS = "*"
        }
        Resource = "*"
        Sid      = "Enable IAM User Permissions"
      },
    ]
    Version = "2012-10-17"
  })
}


resource "aws_route53_zone" "main" {
  name = "tferrari.com"
}

resource "aws_route53_key_signing_key" "dnssecksk" {
  name = "tferrari.com"
  hosted_zone_id = aws_route53_zone.main.zone_id
  key_management_service_arn = aws_kms_key.domaindnssec.arn
}

resource "aws_route53_hosted_zone_dnssec" "dnssec" {
  depends_on = [
    aws_route53_key_signing_key.dnssecksk
  ]
  hosted_zone_id = aws_route53_key_signing_key.dnssecksk.hosted_zone_id
}

output "aws_route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "aws_route53_zone_name_servers" {
  value = aws_route53_zone.main.name_servers
}
