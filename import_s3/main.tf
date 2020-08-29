provider "aws" {
  region = "us-east-1"
}
resource "aws_s3_bucket" "bar" {
  bucket = "test-bucket-n2"
  acl    = "private"
}
