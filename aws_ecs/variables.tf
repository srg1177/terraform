variable "region" {
  type    = string
  default = "us-east-2"
}

variable "cluster" {
  type        = string
  description = "name of cluster"
  default     = "ecs-simple-cluster"
}

########## VPC ###############
variable "vpc" {
  type        = string
  description = "name of vpc"
  default     = "ecs-vpc"
}
variable "vpc_cidr" {
  description = "VPC CIDR"
  default     = "120.6.0.0/16"
}
##############################

####### PUBLIC SUBNET #######
variable "public_subnet" {
  type        = string
  description = "Public Subnet Name"
  default     = "ecs-public-subnet"
}

variable "public_subnet_cidr" {
  description = "Public Subnet CIDR"
  default     = "120.6.10.0/24"
}
#############################

###### PRIVATE SUBNET #######
variable "private_subnet" {
  type        = string
  description = "Private Subnet Name"
  default     = "ecs-private-subnet"
}

variable "private_subnet_cidr" {
  description = "Private Subnet CIDR"
  default     = "120.6.100.0/24"
}
##############################

#########SSH KEY NAME#########
variable "key_name" {
  type    = string
  default = "AWS_linux.pem"
}