variable "domain_name" {
  description = "The domain name for the Route 53 hosted zone"
  type        = string
}

variable "a_records" {
  description = "A map of A DNS records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = list(string)
  }))
  default = {}
}

variable "cname_records" {
  description = "A map of CNAME DNS records to create"
  type = map(object({
    name    = string
    ttl     = number
    records = string
  }))
  default = {}
}
