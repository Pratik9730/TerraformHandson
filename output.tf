output "ec2_public_ip" {
  value = [
      for instance in aws_instance.trial1 : instance.public_ip
  ]
}

output "ec2_private_ip" {
  value = [
    for instance in aws_instance.trial1 : instance.private_ip
  ]
}