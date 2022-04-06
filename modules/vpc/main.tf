resource "aws_vpc" "vpc" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"
  tags             = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-vpc"
  }
}

resource "aws_internet_gateway" "gateway" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-ig"
  }
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.vpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gateway.id
  }
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-public-rt"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.vpc.id
  route  = []
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-private-rt"
  }
}

resource "aws_subnet" "public_subnet" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = "10.0.1.0/24"
  availability_zone       = "us-east-1a"
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-public-subnet"
  }
}

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-private-subnet"
  }
}

resource "aws_route_table_association" "public_subnet_route_table_assoc" {
  subnet_id      = aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_route_table_assoc" {
  subnet_id      = aws_subnet.private_subnet.id
  route_table_id = aws_route_table.private_rt.id
}

variable "subnet_id" {
  default = ""
}

variable "common_tags" {
  type = map
}

output "vpc_id_output" {
  value = aws_vpc.vpc.id
}

output "vpc_subnet_output" {
  value = aws_subnet.public_subnet.id
}
