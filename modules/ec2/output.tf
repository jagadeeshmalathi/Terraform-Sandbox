output "public_ip" {
  value = aws_instance.my_ec2[*].public_ip
}

output "private_ip" {
  value = aws_instance.my_ec2[*].private_ip
}

output "my_ec2_id" {
  value = aws_instance.my_ec2[*].id
}

output "my_ec2_state" {
  value = aws_instance.my_ec2[*].instance_state
}

# below block shows the ARN of EC2 instance

output "my_ec2_arn" {
  value = aws_instance.my_ec2[*].arn
}
