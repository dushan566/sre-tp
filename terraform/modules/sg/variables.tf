variable "environment_name" {}

variable "vpc_id" {}

variable "vpc_cidr" {}

variable "role" {}

variable "is_api_public" {
  default = ""
}

variable "tags" {
  type = map
}