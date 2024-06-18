terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}
/*
provider "aws" {
  region = "us-east-1"
  profile = "harsha"
}

resource "aws_iam_user" "user1" {
  name = "naruto"
}

resource "aws_iam_user" "user2" {
  name = "one"
}

resource "aws_iam_group" "group1" {
 name = "numbers"
}

resource "aws_iam_user_group_membership" "grpadd" {
   user = aws_iam_user.user1.name
   
   groups = [
          aws_iam_group.group1.name
         ]
}
resource "aws_iam_user_group_membership" "grpadd1" {
   user = aws_iam_user.user2.name
   
   groups = [
          aws_iam_group.group1.name
         ]
}

resource "aws_s3_bucket" "bucket" {
  bucket = "harsha-s3-bucket"
}

resource "aws_s3_bucket_ownership_controls" "bucket1" {
  bucket = aws_s3_bucket.bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "bucket2" {
  bucket = aws_s3_bucket.bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "bucket3" {
  depends_on = [
    aws_s3_bucket_ownership_controls.bucket1,
    aws_s3_bucket_public_access_block.bucket2,
  ]

  bucket = aws_s3_bucket.bucket.id
  acl    = "public-read"
}

#userdata
resource "aws_instance" "vm-01" {
  ami = "ami-08a0d1e16fc3f61ea"
  instance_type = "t2.micro"
  key_name = "terraform"

  tags = {
    Name = "vm-01"
  
}
user_data = <<-EOF
#!/bin/bash
sudo yum install nginx -y
sudo systemctl start nginx
sudo systemctl enable nginx
echo "hello" >> /var/www/html/index.html
EOF
}
*/

#vpc
resource "aws_vpc" "vpc" {
  cidr_block = "10.0.0.0/22"
  tags = {
    Name = "vpc-terraform"
  }
}

resource "aws_subnet" "public" {
  vpc_id = aws_vpc.vpc.id
  cidr_block = "10.0.0.0/26"
  availability_zone = "us-east-1a"
  tags = {
    Name = "public-subnet"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id
}
resource "aws_route_table" "route" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "rt"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  
}
}
resource "aws_route_table_association" "rt_sub" {
  route_table_id = aws_route_table.route.id
  subnet_id = aws_subnet.public.id
}
#security group
resource "aws_security_group" "tf-sg" {
  name = "terraform-sg"
  description = "allow ssh"
  vpc_id = aws_vpc.vpc.id

  ingress {
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = "terraform-sg"
  }
}
#instance
resource "aws_instance" "vm" {
  ami               = "ami-08a0d1e16fc3f61ea"
  instance_type     = "t2.micro"
  key_name          = "terraform"
  availability_zone = "us-east-1"
  vpc_security_group_ids = [aws_security_group.tf-sg.id]

  tags = {
    Name = "vm-terraform"
  }
}
output "instance_id" {
  description = "print instance id"
  value       = aws_instance.pub-vm.id
}

output "instance_public_ip" {
  description = "print public ip"
  value       = aws_instance.pub-vm.public_ip
}











