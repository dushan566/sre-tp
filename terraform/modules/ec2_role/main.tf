# IAM Role.
resource "aws_iam_role" "iam_role" {
  name = lower("${var.environment_name}-${var.role}-iam-role")
  assume_role_policy = var.assume_role_policy

  lifecycle {
    create_before_destroy = true
  }
}

# Attach provided managed policies to the role.
resource "aws_iam_role_policy_attachment" "managed_policy_attachments" {
  for_each = var.managed_policy_arns
  role = aws_iam_role.iam_role.name
  policy_arn = each.value
}

# ec2 Role
resource "aws_iam_instance_profile" "ec2_role" {
  name = lower("${var.environment_name}-${var.role}-ec2-role")
  role = "${aws_iam_role.iam_role.name}"
}