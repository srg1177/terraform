provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" "s3_website" {
  bucket = var.bucket
  acl    = var.acl

  website {
    index_document = "index.html"
    error_document = "error.html"

  }
}

locals {
  s3_origin_id = var.origin_id
}