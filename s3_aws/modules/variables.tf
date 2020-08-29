variable "acl" {
  type    = string
  default = "private"
}

variable "tags" {
  type = map(string)
  default = {
    Name  = "My bucket"
    env   = "Staging"
    owner = "Sargis Hayrapetyan"
  }

}