resource "aws_vpc" "my-vpc" {
    cidr_block = var.vpc_cidr_block
    tags = {
    name = "aws_vpc"
  }
}
resource "aws_subnet" "pub-1"{
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.aws_subnet[0]
    availability_zone = var.aws_az[0]
    tags = {
      name = "public1_subnet"
    }
}

resource "aws_subnet" "pub-2" {
  vpc_id = aws_vpc.my-vpc.id
  cidr_block = var.aws_subnet[1]
  availability_zone = var.aws_az[1]
  tags = {
    name = "public2_subnet"
  }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.my-vpc.id
    tags = {
      name = "aws_internet_gateway"
    }
  
}
resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.my-vpc.id
  
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
}

resource "aws_route_table_association" "rt_1" {
  subnet_id = aws_subnet.pub-1.id
  route_table_id = aws_route_table.rt.id
}
resource "aws_route_table_association" "rt_2" {
  subnet_id = aws_subnet.pub-2.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "tf-sg" {
  name = "aws-terraform"
  vpc_id = aws_vpc.my-vpc.id
  
ingress {
  from_port = var.sg_ports[0]
  to_port = var.sg_ports[0]
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
ingress {
  from_port = var.sg_ports[1]
  to_port = var.sg_ports[1]
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
ingress {
  from_port = var.sg_ports[2]
  to_port =var.sg_ports[2] 
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
ingress {
  from_port = var.sg_ports[3]
  to_port = var.sg_ports[3]
  protocol = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}
egress {
  from_port = var.sg_ports[4]
  to_port =var.sg_ports[4]
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_instance" "tf-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = aws_subnet.pub-1.id
  key_name      = var.key_name
  vpc_security_group_ids = [aws_security_group.tf-sg.id]

  tags = {
    Name = var.instance_tags.Name,
    Environment = var.instance_tags_dev.Environment

  }
}

resource "aws_instance" "tf-2" {
  ami = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.pub-2.id
  key_name = var.key_name
  vpc_security_group_ids = [aws_security_group.tf-sg.id]

  tags = {
    Name = var.instance_tags.Name,
    Environment = var.instance_tags_dev.Environment

  }
}















