resource "aws_instance" "web-2" {
  ami = var.ami
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group]
  subnet_id = var.subnet_id
  associate_public_ip_address = true


  tags = {
    Name="web-2"
  }

}



