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
