resource "aws_s3_bucket_policy" "my_emails" {
  bucket = aws_s3_bucket.my_emails.id
  policy = jsonencode({
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AllowSESPuts",
            "Effect": "Allow",
            "Principal": {
                "Service": "ses.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "${aws_s3_bucket.my_emails.arn}",
            "Resource": "${aws_s3_bucket.my_emails.arn}/*",
            "Condition": {
                "StringEquals": {
                    "aws:Referer": "${data.terraform_remote_state.base_state.outputs.account_id}"
                }
            }
        }
    ]  
    
  })

  depends_on = [aws_s3_bucket.my_emails]

}