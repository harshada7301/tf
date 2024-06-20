variable "vpc_cidr_block" {
    type = string
    
}

variable "aws_subnet" {
    type = list(string)
   
}

variable "aws_az" {
    type = list(string)
    
}

variable "sg_ports"{
    type = list(number)
    
}

variable "ami_id" {
    type = string
   
}

variable "instance_type" {
    type = string
   
}

variable "key_name" {
  type = string
  
}

variable "instance_tags" {
  type = map(string)
}
  
variable "instance_tags_dev" {
  type = map(string)
  
}
  