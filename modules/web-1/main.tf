#Creating ec2 instance
resource "aws_instance" "web-1" {
  ami = var.ami
  instance_type = "t2.micro"
  key_name = var.key_name
  vpc_security_group_ids = [var.security_group]
  subnet_id = var.subnet_id
  associate_public_ip_address = true

  user_data = <<-EOF
  #!/bin/bash
  echo "*** Installing apache2"
  sudo apt update -y
  sudo apt install apache2 -y
  echo "*** Completed Installing apache2"
  vim index.html
  <html><body><h1>Hello i am Rohan Ranjan here</h1></body></html>
  EOF




  tags = {
    Name="web-1"
  }
}
















