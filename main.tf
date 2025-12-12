#EC2_instance

resource "aws_instance" "my_ec2" {
ami = "ami-068c0051b15cdb816"
instance_type = "t2.micro"
vpc_security_group_ids = [aws_security_group.my_sg.id]
}

#security_group

resource "aws_security_group" "my_sg" {
  name        = "my-terraform-sg"
  description = "Allow SSH and HTTP inbound traffic"


  # Inbound rules
  ingress {
    description = "Allow SSH from anywhere"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Outbound rules
  egress {
    description = "Allow all outbound traffic"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "terraform-sg"
  }
}