variable "environment_name" {}

variable "role" {}

variable "managed_policy_arns" {
  type = set(string)
  default = []
  description = "ARNs of managed IAM policies to be attached to the role"
}

variable "assume_role_policy" {
  type = string
  description = "JSON string for Assume Role Policy"
}

variable "tags" {
  type = map
}