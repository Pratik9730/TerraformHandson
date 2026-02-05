packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = "~> 1.2"
    }
  }
}

source "amazon-ebs" "base" {
  region        = "us-east-1"
  instance_type = "t2.micro"
  source_ami    = "ami-0b6c6ebed2801a5cb" # Ubuntu AMI ID from AWS I have picked up
  ssh_username  = "ubuntu"
  ami_name      = "ansible-image-2"
}

build {
  sources = ["source.amazon-ebs.base"]

  provisioner "shell" {
    inline = [
      "sudo apt update -y",
      "sudo apt install -y python3 git ansible"
    ]
  }
}