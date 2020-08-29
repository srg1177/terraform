provider "aws" {
  region     = "us-east-2"
}

module "s3_aws" {
  source = "./modules"
}