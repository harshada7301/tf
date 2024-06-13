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



