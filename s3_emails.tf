resource "aws_s3_bucket" "my_emails" {
  bucket = "emails.aaronlangley.net"
  acl    = "private"

  lifecycle {
    prevent_destroy = true
  }

}