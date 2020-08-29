provider "aws" {
  region = "us-east-2"
}

resource "aws_s3_bucket" "foo" {
  bucket = "my-bucket-n-1"
  acl    = var.acl
  tags   = var.tags
}

resource "aws_s3_bucket" "loo" {
  bucket = "my-bucket-n-2"
  acl    = var.acl
  tags   = var.tags
}