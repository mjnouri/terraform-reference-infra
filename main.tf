module "ec2" {
  source = "git@github.com:mjnouri/terraform-modules.git//ec2"
  ami = "ami-0c02fb55956c7d316"
  instance_type = "t3.small"
  env = "dev"
  project_name = "module-testing"
}
