resource "aws_route53_zone" "main" {
  name = "tferrari.com"
}

output "aws_route53_zone_id" {
  value = aws_route53_zone.main.zone_id
}

output "aws_route53_zone_name_servers" {
  value = aws_route53_zone.main.name_servers
}


resource "aws_route53_zone" "sub" {
  name = "nginx.tferrari.com"
}

output "aws_route53_zone_id_sub" {
  value = aws_route53_zone.sub.zone_id
}

output "aws_route53_zone_name_servers_sub" {
  value = aws_route53_zone.sub.name_servers
}