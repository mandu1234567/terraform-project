locals {
    rds_db_password = sensitive(data.aws_ssm_parameter.rds_db_password.value)
}

resource "aws_db_subnet_group" "name" {
    name       = "${var.env_name}-db-subnet-group"
    description = "Subnet group for RDS instance"
    subnet_ids = var.private_subnet_ids
    tags = {
      Name       = "${var.env_name}-db-subnet-group"
    }
}

resource "aws_security_group" "name" {
    name        = "${var.env_name}-rds-security-group"
    description = "Security group for RDS instance"
    vpc_id      = var.vpc_id

    ingress {
        from_port   = 3306
        to_port     = 3306
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

resource "aws_db_instance" "rds_instance" {
  identifier              = "${var.env_name}-db-instance"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"

  username                = var.rds_db_username
  password                = local.rds_db_password

  storage_encrypted       = true
  kms_key_id              = data.aws_kms_key.aws_managed_rds_key.arn

  db_subnet_group_name    = aws_db_subnet_group.name.name
  vpc_security_group_ids  = [aws_security_group.name.id]

  skip_final_snapshot     = true

  tags = {
    Name = "${var.env_name}-db-instance"
  }
}