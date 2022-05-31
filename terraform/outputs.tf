output "sg_id" {
    value = module.sg.sg_id
}

output "iam_role_name" {
  value = module.ec2_role.iam_role_name
}

output "iam_role_arn" {
  value = module.ec2_role.iam_role_arn
}

output "private_ip_addresses" {
  value = module.instances.private_ip_addresses
}

output "elastic_ip_addresses" {
  value = module.instances.elastic_ip_addresses
}

output "instances_ids" {
  value = module.instances.instances_ids
}