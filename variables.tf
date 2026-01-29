variable "instance_type" {
    default = "t3.micro"
    type = string
}

variable "ami_id" {
    default = "ami-0b6c6ebed2801a5cb"
    type = string
}

variable "volume_size" {
    default = 15
    type = number
}

