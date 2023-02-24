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
  sudo rm /var/www/html/index.html
  sudo curl -O https://raw.githubusercontent.com/Rohanranjan51/web-file-copy-test/e1cba2efb0bf2e9175c71840abf1f4378ee003cd/index.html
  sudo cp index.html /var/www/html
  sudo rm index.html
  EOF

  tags = {
    Name="web-1"
  }
}










