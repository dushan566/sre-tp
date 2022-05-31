variable "region" {}

variable "environment_name" {}

variable "role" {}

variable "key_name" {}

variable "instances_ami" {}

variable "instances_type" {}

variable "vpc_id" {}

variable "vpc_cidr" {}

variable "pub_subnet_ids" {}

variable "tags" {
  type = map
}