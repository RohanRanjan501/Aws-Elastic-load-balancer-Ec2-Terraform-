output "url" {
  value = "http://${aws_instance.web-2.public_ip}"
}

output "public_ip" {
  value = aws_instance.web-2.public_ip
}

output "private_ip" {
  value = aws_instance.web-2.private_ip
}

output "web_instance_ip" {
  value = aws_instance.web-2.public_ip
}

output "instance_id" {
  value = aws_instance.web-2.id
}