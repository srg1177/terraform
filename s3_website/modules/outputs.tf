output "BUCKET_NAME" {
  value = aws_s3_bucket.s3_website.bucket
}

output "BUCKET_ID" {
  value = aws_s3_bucket.s3_website.id
}