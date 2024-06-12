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
  profile = "devops-tf"
}
# create iam user and groups
resource "aws_iam_user" "demo" {
  name = "mahesh"

}

resource "aws_iam_user" "demo1" {
  name = "salonie"
}

resource "aws_iam_user" "demo2" {
  name = "ankita"
}

resource "aws_iam_group" "grp" {
  name = "team-dev"
}

resource "aws_iam_user_group_membership" "grpadd" {
   user = aws_iam_user.demo1.name
   
   groups = [
          aws_iam_group.grp.name
         ]
}
resource "aws_iam_user_group_membership" "grpadd2" {
   user = aws_iam_user.demo2.name

   groups = [
          aws_iam_group.grp.name
         ]
}
resource "aws_iam_user_group_membership" "grpadd3" {
   user = aws_iam_user.demo.name
   groups = [
         aws_iam_group.grp.name
       ]
}


# code for creating s3 bucket
resource "aws_s3_bucket" "bucket-1" {
  bucket = "mangesh-baltiwala"
   
}
resource "aws_s3_bucket_ownership_controls" "example" {
  bucket =aws_s3_bucket.bucket-1.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}
resource "aws_s3_bucket_acl" "achal" {
  bucket = aws_s3_bucket.bucket-1.id
  acl = "private"
}











