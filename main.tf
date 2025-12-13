resource "aws_instance" "dev" {
  ami = "ami-068c0051b15cdb816"
  instance_type = "t3.micro"
  key_name = "Webserver_Key.pem"
}

resource "aws_security_group" "ssh_only" {
  name_prefix = "resourses_key"
  
  ingress {
    description = "SSH from my IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["YOUR.IP.ADDRESS/32"]  # ← Replace with your IP: `curl ifconfig.me`
  }
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]  # All outbound traffic
  }
  
  tags = {
    Name = "Jagadeesh-SSH-Only-SG"
  }
}