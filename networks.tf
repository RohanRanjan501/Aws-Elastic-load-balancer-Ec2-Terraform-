resource "aws_vpc" "development-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "VPC LAMP"
  }

}

resource "aws_subnet" "tf-web-1" {
  cidr_block        = "10.0.1.0/24"
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "ap-south-1a"
  tags = {
    Name = "tf-web-1"
  }

}

resource "aws_subnet" "tf-web-2" {
  cidr_block        = "10.0.2.0/24"
  vpc_id            = aws_vpc.development-vpc.id
  availability_zone = "ap-south-1b"
  tags = {
    Name = "tf-web-2"
  }
}

resource "aws_internet_gateway" "ig_aws" {
  vpc_id = aws_vpc.development-vpc.id

  tags = {
    Name = "IGW"
  }
}

resource "aws_route" "route_web" {
  route_table_id         = aws_vpc.development-vpc.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.ig_aws.id
}

resource "aws_security_group" "security_group" {

  name="sec-group"
  description = "Web security group for HTTP"
  vpc_id = aws_vpc.development-vpc.id

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port = 22
    protocol  = "tcp"
    to_port   = 22
    cidr_blocks = ["0.0.0.0/0"]

  }



  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags={
    Name = "security-group"
  }
}

resource "aws_lb_target_group" "target-group" {
  name = "target"
  port = 80
  protocol = "HTTP"
  vpc_id = aws_vpc.development-vpc.id
  target_type = "instance"

  health_check {
    enabled = true
    healthy_threshold = 3
    interval = 10
    matcher = "200"
    path = "/"
    port = "traffic-port"
    protocol = "HTTP"
    timeout = 3
    unhealthy_threshold = 2
  }
}
resource "aws_lb" "application_lb" {
  name = "web1-alb"
  internal = false
  ip_address_type = "ipv4"
  load_balancer_type = "application"
  security_groups = [aws_security_group.security_group.id]
  subnets = [aws_subnet.tf-web-1.id,aws_subnet.tf-web-2.id]

  enable_deletion_protection = false
  idle_timeout = 60

}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.application_lb.arn
  port = 80
  protocol = "HTTP"

  default_action {
    type = "forward"
    target_group_arn = aws_lb_target_group.target-group.arn

  }
}


resource "aws_lb_target_group_attachment" "main-1" {

    target_group_arn = aws_lb_target_group.target-group.arn
    target_id        = module.web-1.instance_id

}

resource "aws_lb_target_group_attachment" "main-2" {

  target_group_arn = aws_lb_target_group.target-group.arn
  target_id        = module.web-2.instance_id
}







