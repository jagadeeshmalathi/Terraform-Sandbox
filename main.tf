module "my_ec2" {
  source      = "./modules/ec2"

count         = 2
ami           = "ami-0cca134ec43cf708f"
instance_type = "t3.small"
sg_name       = "my-tf-sg"
}
