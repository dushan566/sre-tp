output "iam_role_name" {
  value = aws_iam_instance_profile.ec2_role.name
}

output "iam_role_arn" {
  value = aws_iam_instance_profile.ec2_role.arn
}
