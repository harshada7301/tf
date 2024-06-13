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