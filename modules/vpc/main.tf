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
  count                   = (lookup(var.common_tags, "env") == "prod") ? 3 : 2
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.public_subnet_cidr[count.index]
  availability_zone       = var.az[count.index]
  map_public_ip_on_launch = "true"
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-public-subnet-${count.index}"
  }
}

resource "aws_subnet" "private_subnet" {
  count             = (lookup(var.common_tags, "env") == "prod") ? 3 : 2
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.private_subnet_cidr[count.index]
  availability_zone = var.az[count.index]
  tags = {
    Name = "${lookup(var.common_tags, "project_name")}-${lookup(var.common_tags, "env")}-private-subnet-${count.index}"
  }
}

resource "aws_route_table_association" "public_subnet_route_table_assoc" {
  count          = (lookup(var.common_tags, "env") == "prod") ? 3 : 2
  subnet_id      = aws_subnet.public_subnet[count.index].id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "private_subnet_route_table_assoc" {
  count          = (lookup(var.common_tags, "env") == "prod") ? 3 : 2
  subnet_id      = aws_subnet.private_subnet[count.index].id
  route_table_id = aws_route_table.private_rt.id
}


# Variables

variable "public_subnet_cidr" {
  default = [ "10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24" ]
}

variable "private_subnet_cidr" {
  default = [ "10.0.4.0/24", "10.0.5.0/24", "10.0.6.0/24" ]
}

variable "az" {
  default = [ "us-east-1a", "us-east-1b" , "us-east-1c" ]
}

variable "common_tags" {
  type = map
}


# Outputs

output "vpc_id_output" {
  value = aws_vpc.vpc.id
}

output "public_subnet_id_output" {
  value = aws_subnet.public_subnet[*].id
}
