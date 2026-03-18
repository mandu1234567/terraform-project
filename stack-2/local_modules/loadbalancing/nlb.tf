resource "aws_lb_target_group" "nlb_target_group" {
  name     = "${var.env_name}-backend-tg"
  port     = 8084
  protocol = "TCP"
  vpc_id   = var.vpc_id

  health_check {
    protocol = "HTTP"
    port     = 8084
    path     = "/actuator"
  }

  tags = {
    Name = "${var.env_name}-backend-tg"
  }
}
resource "aws_security_group" "nlb_sg" {
  name   = "${var.env_name}-backend-nlb-sg"
  vpc_id = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.vpc_cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
resource "aws_lb" "net_lb" {
  name               = "${var.env_name}-backend-lb"
  internal           = true
  load_balancer_type = "network"
  subnets            = var.private_subnet_ids
  enable_deletion_protection = false
  security_groups    = [aws_security_group.nlb_sg.id]

  tags = {
    Name = "${var.env_name}-backend-nlb"
  }
}

resource "aws_lb_listener" "nlb_listener" {
  load_balancer_arn = aws_lb.net_lb.arn
  port              = 80
  protocol          = "TCP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.nlb_target_group.arn
  }
}