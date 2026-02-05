variable "instance_type" {
    default = "t3.micro"
    type = string
}

variable "ami_id" {
    default = "ami-0325f3e5651e7d58f"
    type = string
}

variable "volume_size" {
    default = 15
    type = number
}

variable "env" {
    default = "dev"
    type = string
  
}
