resource "aws_instance" "instance" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = var.key_name
  vpc_security_group_ids = var.vpc_security_group_ids
  subnet_id              = var.subnet_id[0]
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-ec2"
  }
}

variable "ami" {
  default = ""
}

variable "instance_type" {
  default = ""
}

variable "key_name" {
  default = ""
}

variable "subnet_id" {
  type    = list(string)
  default = []
}

variable "common_tags" {
  type = map
}

variable "vpc_security_group_ids" {
  type = set(string)
  default = []
}
