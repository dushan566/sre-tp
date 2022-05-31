provider "aws" {
  region  = var.region
}


module "sg" {
  source                 = "./modules/sg/"
  environment_name       = var.environment_name
  role                   = var.role
  vpc_cidr               = var.vpc_cidr
  vpc_id                 = var.vpc_id
  tags                   = var.tags
}

module "ec2_role" {
  source                = "./modules/ec2_role"
  environment_name      = var.environment_name
  role                  = var.role
  assume_role_policy     = data.aws_iam_policy_document.instance-assume-role-policy.json
  managed_policy_arns   = [
    "arn:aws:iam::aws:policy/AmazonSSMFullAccess"
  ]
  tags                  = var.tags
}

module "instances" {
  environment_name       = var.environment_name
  region                 = var.region
  source                 = "./modules/instance/"
  ami                    = var.instances_ami
  instances_count        = 1
  instance_type          = var.instances_type
  iam_instance_profile   = module.ec2_role.iam_role_name
  key_name               = var.key_name
  vpc_id                 = var.vpc_id
  subnet_id              = element(var.pub_subnet_ids, 0) 
  role                   = var.role
  sg_id                  = module.sg.sg_id
  volume_size            = 10
  tags                   = var.tags
}