  locals {
  user_data = templatefile("${path.module}/include/user-data-be.tpl", {
    env_name        = var.env_name
    jar_file        = var.jar_file_name
    be_app_bucket = data.terraform_remote_state.app_buckets.outputs.bucket_be
    rds_db_username = var.rds_db_username
    rds_db_endpoint = var.rds_db_endpoint
    rds_db_password = data.aws_ssm_parameter.rds_db_password.value
  })
}
resource "aws_security_group" "be_asg_sg" {
  name        = "${var.env_name}-be_asg-sg"
  description = "Security group for ASG instances(backend)."
  vpc_id      = var.vpc_id

  ingress {
    description      = "Allow HTTP traffic from NLB SG"
    from_port        = 8084
    to_port          = 8084
    protocol         = "tcp"
    cidr_blocks      = [var.vpc_cidr]
  }

    egress {
        description = "Allow all outbound traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
      }
}

resource "aws_key_pair" "app_key_pair" {
  key_name   = "${var.env_name}-key"
  public_key = file("${path.module}/include/mykey.pub")
}


resource "aws_iam_instance_profile" "be_profile" {
  name = "${var.env_name}-access-profile"
  role = aws_iam_role.be_inst_role.name
}

resource "aws_launch_template" "backend_app_launch_template" {
  name_prefix          = "app-instance"
  image_id             = data.aws_ami.linux_2023.id
  instance_type        = var.instance_type

  user_data            = base64encode(local.user_data)
  key_name             = aws_key_pair.app_key_pair.key_name

  iam_instance_profile {
    arn = aws_iam_instance_profile.be_profile.arn
  }

  network_interfaces {
    associate_public_ip_address = false
    device_index                = 0
    subnet_id                   = var.private_subnet_id[0]
    security_groups             = [aws_security_group.be_asg_sg.id]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "backend_app_asg" {
  name                 = "${var.env_name}-asg"
  desired_capacity     = var.desired_capacity
  max_size             = var.max_size
  min_size             = var.min_size
  vpc_zone_identifier  = var.private_subnet_id

  launch_template {
    id      = aws_launch_template.backend_app_launch_template.id
    version = "$Latest"
  }

  health_check_type          = "EC2"
  health_check_grace_period  = 300
  force_delete               = true
  wait_for_capacity_timeout  = "0"

  tag {
    key                 = "created_by"
    value               = "${var.env_name}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.backend_app_asg.name
  lb_target_group_arn    = var.nlb_tg_arn
}