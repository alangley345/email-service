resource "aws_ses_receipt_rule_set" "my_emails" {
  rule_set_name = "Rules-for-My-Email"
}

resource "aws_ses_receipt_rule" "my_s3_bucket" {
  name          = "Store-in-S3-Bucket"
  rule_set_name = "Rules-for-My-Email"
  recipients    = ["me@aaronlangley.net"]
  enabled       = true
  scan_enabled  = true

  add_header_action {
    header_name  = "Custom-Header"
    header_value = "Received by SES"
    position     = 1
  }

  s3_action {
    bucket_name = "emails.aaronlangley.net"
    position    = 2
  }

  depends_on = [aws_ses_receipt_rule_set.my_emails]
}
