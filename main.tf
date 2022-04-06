module "vpc" {
# source       = "git@github.com:mjnouri/terraform-modules.git//vpc"
  source       = "./modules/vpc"
  env          = var.env
  project_name = var.project_name
}

module "ubuntu_ami" {
# source = "git@github.com:mjnouri/terraform-modules.git//ubuntu-ami"
  source = "./modules/ubuntu-ami"
}

module "jenkins-controller-ec2" {
# source                 = "git@github.com:mjnouri/terraform-modules.git//ec2"
  source                 = "./modules/ec2"
  ami                    = module.ubuntu_ami.ubuntu_ami_output
  instance_type          = var.instance_type
  vpc_security_group_ids = module.sg.sg_output
  subnet_id              = module.vpc.vpc_subnet_output
  key_name               = var.key_name
  env                    = var.env
  project_name           = var.project_name
}

module "sg" {
# source           = "git@github.com:mjnouri/terraform-modules.git//sg"
  source           = "./modules/sg"
  ingress_port     = var.ingress_port
  ingress_protocol = var.ingress_protocol
  ingress_cidr     = var.ingress_cidr
  env              = var.env
  project_name     = var.project_name
  vpc_id           = module.vpc.vpc_id_output
}
