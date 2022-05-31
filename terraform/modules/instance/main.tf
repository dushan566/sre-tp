terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

resource "aws_instance" "ec2-instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  subnet_id              = var.subnet_id
  key_name               = var.key_name
  vpc_security_group_ids = [var.sg_id]
  count                  = var.instances_count
  iam_instance_profile   = var.iam_instance_profile
  tags                   = merge(var.tags, tomap({"Name" = lower("${var.environment_name}-${var.role}-ec2")}))

  root_block_device {
    volume_size            = var.volume_size
  }
}

resource "aws_ebs_volume" "ebs_volume" {
  availability_zone = "${var.region}a"
  size              = 10
  count             = var.instances_count
  tags = var.tags
}

resource "aws_volume_attachment" "ebs_volume_attach" {
  device_name = "/dev/sdf"
  count             = var.instances_count
  volume_id   = element(aws_ebs_volume.ebs_volume.*.id, count.index)
  instance_id = element(aws_instance.ec2-instance.*.id, count.index)
}

resource "aws_eip" "instance_ips" {
  instance = element(aws_instance.ec2-instance.*.id, count.index)
  vpc      = true
  count    = var.instances_count
  tags     = merge(var.tags, tomap({"Name" = lower("${var.environment_name}-${var.role}-eip")}))
}
