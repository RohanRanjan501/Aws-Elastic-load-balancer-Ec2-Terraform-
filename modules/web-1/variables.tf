variable "vpc_id" {
  description = "Vpc id for Terraform"
}

variable "subnet_id" {

  description = "Subnet id for db servers"
}

variable "ami" {
  default = "ami-000ed5810ea2ca0a0"
}

variable "key_name" {
  description = "SSH key used for the servers"
}

variable "security_group" {
  default ="sec group"
}

