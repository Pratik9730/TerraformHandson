#Key_pair
resource "aws_key_pair" "ec2_key" {
    key_name = "ec2_key"
    public_key = file("C:/Users/pratik.yangandalwar/Terraform_Projects/Variable and output block/key_pair/ec2_key.pub")
  
}


#Default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

#Security Group
resource "aws_security_group" "aws_security_group" {
    name = "aws_security_group"
    description = "trying the ec2 connect"
    vpc_id = aws_default_vpc.default.id

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allowed all traffic"

    }

     ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allowed all 8080 traffic"

    }
    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

#Ec2 instance
resource "aws_instance" "trial1" {
    count = 3
    key_name = aws_key_pair.ec2_key.key_name
     vpc_security_group_ids = [
    aws_security_group.aws_security_group.id
  ]
    ami = var.ami_id
    instance_type = var.instance_type

    root_block_device {
      volume_type = "gp3"
      volume_size = var.volume_size
    }

    tags = {

      "with" = "terraform"
      Name = "app-${count.index}"
    }
}