variable "ami" {
 description = "ami id"
 type = string
}

variable "instance_type" {
 description = "instance_type of ec2"
 type    = string
}

variable "count-num" {
 description = "creates number of ec2"
 type = number
}

variable "sg_name" {
 description = "Security group for my ec2"
 type        = string
}
