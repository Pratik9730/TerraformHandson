output "ec2_public_ip" {
  value = aws_instance.trial1[*].public_ip
}

output "ec2_private_ip" {
    value = aws_instance.trial1[*].private_ip
  
}