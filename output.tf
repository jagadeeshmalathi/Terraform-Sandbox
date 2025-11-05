output "my_ec2_arn" {
  value       = aws_instance.my_ec2.arn
  description = "The ARN of the EC2 instance"
}
output "my_ec2_id" {
  value       = aws_instance.my_ec2.id
  description = "The ID of the EC2 instance"
}
output "my_ec2_private_ip" {
  value       = aws_instance.my_ec2.private_ip
  description = "The private IP address of the EC2 instance"
}