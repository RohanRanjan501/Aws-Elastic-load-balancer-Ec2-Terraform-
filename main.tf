provider "aws" {
  region = var.region
}

module "web-1" {
  source    = "./modules/web-1"
  key_name  = var.key_name
  subnet_id = aws_subnet.tf-web-1.id
  vpc_id    = aws_vpc.development-vpc.id
  security_group = aws_security_group.security_group.id


}


module "web-2" {
  source = "./modules/web-2"

  key_name  = var.key_name
  subnet_id = aws_subnet.tf-web-2.id
  vpc_id    = aws_vpc.development-vpc.id
  security_group = aws_security_group.security_group.id
}


