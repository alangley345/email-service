resource "aws_route53_record" "mail" {
  zone_id = data.terraform_remote_state.base_state.outputs.aaronlangley_zone_id
  name    = "aaronlangley.net"
  type    = "MX"
  ttl     = "300"
  records = ["10 inbound-smtp.us-east-1.amazonaws.com."]
}