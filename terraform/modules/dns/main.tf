resource "aws_route53_zone" "this" {
  name = var.domain_name
}

resource "aws_route53_record" "a_records" {
  for_each = var.a_records

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = "A"
  ttl     = each.value.ttl
  records = each.value.records
}

resource "aws_route53_record" "cname_records" {
  for_each = var.cname_records

  zone_id = aws_route53_zone.this.zone_id
  name    = each.value.name
  type    = "CNAME"
  ttl     = each.value.ttl
  records = [each.value.records]
}
