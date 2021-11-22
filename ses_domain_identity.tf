resource "aws_ses_domain_identity" "aaronlangley" {
  domain = "aaronlangley.net"
}

#Route 53 record
resource "aws_route53_record" "aaronlangley_ses_verification_record" {
  zone_id = data.terraform_remote_state.base_state.outputs.aaronlangley_zone_id
  name    = "_amazonses.aaronlangley.net"
  type    = "TXT"
  ttl     = "600"
  records = [aws_ses_domain_identity.aaronlangley.verification_token]

  depends_on = [aws_ses_domain_identity.aaronlangley]
}

#dkim 
resource "aws_ses_domain_dkim" "aaronlangley" {
  domain = aws_ses_domain_identity.aaronlangley.domain
}

#iterates through specified count and creates records appending the end of the string as appropriate
resource "aws_route53_record" "aaronlangley_ses_dkim_record" {
  count   = 1
  zone_id = data.terraform_remote_state.base_state.outputs.aaronlangley_zone_id
  name    = "${element(aws_ses_domain_dkim.aaronlangley.dkim_tokens, count.index)}._domainkey"
  type    = "CNAME"
  ttl     = "600"
  records = ["${element(aws_ses_domain_dkim.aaronlangley.dkim_tokens, count.index)}.dkim.amazonses.com"]

  depends_on = [aws_ses_domain_dkim.aaronlangley]
}