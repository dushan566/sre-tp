variable "environment_name" {}

variable "region" {}

variable "ami" {}

variable "instance_type" {}

variable "key_name" {}

variable "subnet_id" {}

variable "vpc_id" {}

variable "instances_count" {}

variable "volume_size" {}

variable "role" {}

variable "iam_instance_profile" {
  default = ""
}

variable "sg_id" {}

variable "tags" {
  type = map
}