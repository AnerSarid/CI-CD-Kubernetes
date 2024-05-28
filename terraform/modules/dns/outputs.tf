output "zone_id" {
  description = "The ID of the Route 53 hosted zone"
  value       = aws_route53_zone.this.zone_id
}

output "a_records" {
  description = "The A DNS records created"
  value       = aws_route53_record.a_records
}

output "cname_records" {
  description = "The CNAME DNS records created"
  value       = aws_route53_record.cname_records
}
