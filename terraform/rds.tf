resource "aws_db_subnet_group" "main" {
  name       = "main"
  subnet_ids = [aws_subnet.private_subnet_1.id, aws_subnet.private_subnet_2.id]  # Include both private subnets
  tags = {
    Name = "main-db-subnet-group"
  }
}

resource "aws_db_instance" "mysql" {
  identifier             = var.rds_identifier
  db_name                = var.db_name
  allocated_storage      = 20
  engine                 = var.rds_engine_type
  engine_version         = var.rds_engine_version  # Using MySQL 8.0.x
  instance_class         = var.rds_instance_type  # Free tier eligible instance class
  username               = var.db_user
  password               = var.db_password
  publicly_accessible    = false
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.rds_private_sg.id]
  db_subnet_group_name   = aws_db_subnet_group.main.name

  # Disable backups to avoid extra charges
  backup_retention_period = 0

}
