resource "aws_ses_domain_identity" "aaronlangley" {
  domain = "aaronlangley.net"
}


resource "aws_route53_record" "aaronlangley_ses_verification_record" {
  zone_id = data.terraform_remote_state.base_state.outputs.aaronlangley_zone_id
  name    = "_amazonses.aaronlangley.net"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.aaronlangley.verification_token]
}