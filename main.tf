terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.53.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  profile = "harsha"
}
/*
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
*/

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



