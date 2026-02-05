output "ec2_public_ip" {
  value = aws_instance.master.public_ip
}

output "ec2_private_ip" {
  value = aws_instance.slaves[*].private_ip
}