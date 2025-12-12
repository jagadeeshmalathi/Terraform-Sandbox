output "ec2_public_ips" {
  value = module.my_ec2.public_ip
}

output "ec2_private_ips" {
  value = module.my_ec2.private_ip
}
