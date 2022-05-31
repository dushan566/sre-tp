output "private_ip_addresses" {
  value = aws_instance.ec2-instance.*.private_ip
}

output "instances_ids" {
  value = aws_instance.ec2-instance.*.id
}

output "elastic_ip_addresses" {
  value = aws_eip.instance_ips.*.public_ip
}
