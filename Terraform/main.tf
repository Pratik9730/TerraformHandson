#Key_pair
resource "aws_key_pair" "ec2_key" {
    key_name = "ec2_key"
    public_key = file("path_to/key_pair/ec2_key.pub")
  
}

module "project_vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "~> 5.0"

  name = "project_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-east-1a", "us-east-1b"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = false
}
#Security Group
resource "aws_security_group" "aws_security_group" {
    name = "aws_security_group"
    description = "trying the ec2 connect"
    vpc_id = module.project_vpc.vpc_id

    ingress {
        from_port = 0
        to_port = 65535
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "allowed all traffic"

    }

    egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}
resource "aws_instance" "master" {
  ami           = var.ami_id
  instance_type = "t2.micro"
   root_block_device {
      volume_type = "gp3"
      volume_size = var.volume_size
    }
  key_name = aws_key_pair.ec2_key.key_name
       vpc_security_group_ids = [aws_security_group.aws_security_group.id]
  subnet_id = module.project_vpc.public_subnets[0]
  associate_public_ip_address = true
  tags = {
    Name = "ansible-master"
    Role = "master"
  }
}

resource "aws_instance" "slaves" {
  count         = 2
  ami           = var.ami_id
  instance_type = "t2.micro"
   root_block_device {
      volume_type = "gp3"
      volume_size = var.volume_size
    }
  key_name = aws_key_pair.ec2_key.key_name
  vpc_security_group_ids = [aws_security_group.aws_security_group.id]
  subnet_id = module.project_vpc.private_subnets[0]

  tags = {
    Name = "ansible-slave-${count.index}"
    Role = "slave"
  }
}
