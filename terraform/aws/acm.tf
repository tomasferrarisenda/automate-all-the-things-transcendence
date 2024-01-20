# Certificates
resource "aws_acm_certificate" "argocd" {
  domain_name       = "argocd.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "grafana" {
  domain_name       = "grafana.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "harbor" {
  domain_name       = "harbor.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "jaeger" {
  domain_name       = "jaeger.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_acm_certificate" "kiali" {
  domain_name       = "kiali.${var.domain}"
  validation_method = "DNS"

  lifecycle {
    create_before_destroy = true
  }
}


# Validations
resource "aws_acm_certificate_validation" "argocd" {
  certificate_arn         = aws_acm_certificate.argocd.arn
  validation_record_fqdns = ["argocd.${var.domain}"]
#   validation_record_fqdns = [for record in aws_route53_record.example : record.fqdn]
}

resource "aws_acm_certificate_validation" "grafana" {
  certificate_arn         = aws_acm_certificate.grafana.arn
  validation_record_fqdns = ["grafana.${var.domain}"]
}

resource "aws_acm_certificate_validation" "harbor" {
  certificate_arn         = aws_acm_certificate.harbor.arn
  validation_record_fqdns = ["harbor.${var.domain}"]
}

resource "aws_acm_certificate_validation" "jaeger" {
  certificate_arn         = aws_acm_certificate.jaeger.arn
  validation_record_fqdns = ["jaeger.${var.domain}"]
}

resource "aws_acm_certificate_validation" "kiali" {
  certificate_arn         = aws_acm_certificate.kiali.arn
  validation_record_fqdns = ["kiali.${var.domain}"]
}