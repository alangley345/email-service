resource "aws_ses_email_identity" "my_gmail" {
  email = "alangley345@gmail.com"
}

resource "aws_ses_email_identity" "work_email" {
  email = "alangley@chmed.org"
}