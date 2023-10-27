provider "aws" {
  region = "us-east-1"
}

######## data-block fetching ami-id ########
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  owners = ["amazon"] # Canonical
}




########### Instance ###########
resource "aws_instance" "provisionerinstance" {
  ami                    = data.aws_ami.ubuntu.id
  instance_type          = "t2.nano"
  vpc_security_group_ids = [aws_security_group.main.id]

  
  tags = {
    Name = "terraform-cloud-test-instance"
  }




}


resource "aws_security_group" "main" {
  egress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 0
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "-1"
      security_groups  = []
      self             = false
      to_port          = 0
    }
  ]
  ingress = [
    {
      cidr_blocks      = ["0.0.0.0/0", ]
      description      = ""
      from_port        = 22
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      protocol         = "tcp"
      security_groups  = []
      self             = false
      to_port          = 22
    }
  ]
}



