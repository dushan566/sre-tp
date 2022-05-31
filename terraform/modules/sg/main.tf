terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

# Create Security Group
resource "aws_security_group" "security_group" {
  description = "Security group for ec2"
  vpc_id      = var.vpc_id
  name        = "${var.environment_name}-${var.role}-sg"
  tags        = merge(var.tags, tomap({"Name" = lower("${var.environment_name}-${var.role}-sg")}))   
}

# Allow web access
resource "aws_security_group_rule" "allow_all_to_web_service" {
  type              = "ingress"
  to_port           = "80"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "80"
  security_group_id = "${aws_security_group.security_group.id}"
}

# Allow SSH access
resource "aws_security_group_rule" "allow_all_to_ssh" {
  type              = "ingress"
  to_port           = "22"
  protocol          = "TCP"
  cidr_blocks       = ["0.0.0.0/0"]
  from_port         = "22"
  security_group_id = "${aws_security_group.security_group.id}"
}

# Allow outbound traffic
resource "aws_security_group_rule" "allow_outbound_traffic" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_security_group.security_group.id}"
}