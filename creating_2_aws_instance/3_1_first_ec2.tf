provider "aws" {
  region     = "us-east-1"
}

variable "ec2_instance_name" {
  type = list
  default = ["dhruv","krina"]
}

resource "aws_instance" "myec2" {
   ami = "ami-05fa00d4c63e32376"
   instance_type = "t2.micro"
   count=2
   tags = {
   Name = var.ec2_instance_name[count.index]
   }
}
