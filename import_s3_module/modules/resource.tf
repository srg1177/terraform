resource "aws_s3_bucket" "god" {
  bucket_prefix = "import-as-module-1"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}

resource "aws_s3_bucket" "dog" {
  bucket_prefix = "import-as-module-2"
  acl    = "private"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}