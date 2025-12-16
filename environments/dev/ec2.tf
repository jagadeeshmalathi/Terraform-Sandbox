module "my_ec2" {
  source      = "../../modules/ec2"

count-num     = var.count-num
ami           = var.ami
instance_type = var.instance_type
sg_name       = var.sg_name
}
