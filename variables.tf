variable "ami" {
  default = ""
}

variable "instance_type" {
  default = "t3.medium"
}

variable "vpc_security_group_ids" {
  type    = set(string)
  default = []
}

variable "key_name" {
  default = "mark-test"
}

variable "env" {
  default = "dev"
}

variable "project_name" {
  default = "module-testing"
}

variable "ingress_port" {
  default = 8080
}

variable "ingress_protocol" {
  default = "TCP"
}

variable "ingress_cidr" {
  default = ["0.0.0.0/0"]
}

variable "subnet_id" {
  default = ""
}
