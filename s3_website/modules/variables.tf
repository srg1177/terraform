variable "bucket" {
  type        = string
  description = "name of s3 bucket"
  default     = "s3-bucket-for-web-site"
}

variable "acl" {
  type    = string
  default = "public-read"
}