output "url" {
  value = "http://${aws_instance.web-1.public_ip}"
}

output "public_ip" {
  value = aws_instance.web-1.public_ip
}

output "private_ip" {
  value = aws_instance.web-1.private_ip
}



output "web_instance_ip" {
  value = aws_instance.web-1.public_ip
}

output "instance_id" {
  value = aws_instance.web-1.id
}