variable "common_tags" {
  type = map
  default = {
    "env"          = "dev"
    "project_name" = "module-stuff"
  }
}

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
