resource "aws_db_subnet_group" "subnets" {
  name       = "${var.name}-db-subnet-group"
  subnet_ids = var.private_subnets
  tags = {
    Name = "${var.name}-db-subnet-group"
  }
}

resource "aws_security_group" "db_sg" {
  name        = "${var.name}-db-sg"
  vpc_id      = var.vpc_id
  description = "Allow Postgres from ECS"
  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["50.10.0.0/16"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_db_instance" "postgres" {
  identifier             = var.name
  engine                 = var.db_engine
  instance_class         = var.instance_class
  allocated_storage      = var.allocated_storage
  username               = var.db_username
  password               = var.db_password
  db_subnet_group_name   = aws_db_subnet_group.subnets.name
  vpc_security_group_ids = [aws_security_group.db_sg.id]
  skip_final_snapshot    = true
  multi_az               = var.multi_az
  publicly_accessible    = false
  lifecycle {
    ignore_changes = [allocated_storage]
  }
}
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  