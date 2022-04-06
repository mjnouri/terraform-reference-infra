resource "aws_security_group" "sg" {
  name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-sg"

  vpc_id = var.vpc_id

  ingress {
    from_port   = var.ingress_port
    to_port     = var.ingress_port
    protocol    = var.ingress_protocol
    cidr_blocks = var.ingress_cidr
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

variable "ingress_port" {
  default = ""
}

variable "ingress_protocol" {
  default = ""
}

variable "ingress_cidr" {
  default = ""
}

variable "vpc_id" {
  default = ""
}

variable "common_tags" {
  type = map
}

output "sg_output" {
  value = aws_security_group.sg[*].id
}
