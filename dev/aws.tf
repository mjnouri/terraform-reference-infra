terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "= 4.8.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
# default_tags {
#   tags = {
#     project_name = "module_stuff"
#     env          = "dev"
#   }
# }
}
