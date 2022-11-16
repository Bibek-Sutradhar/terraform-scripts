#RDS subnet group
resource "aws_db_subnet_group" "database_subnet" {
  name       = "database_subnet"
  subnet_ids = [aws_subnet.private_subnet1.id, aws_subnet.private_subnet2.id]

  tags = {
    Name = "rds_subnet"
  }
}

#RDS MySQL Engine
resource "aws_db_instance" "rds_mysql_db" {
  allocated_storage    = 10
  db_subnet_group_name = aws_db_subnet_group.database_subnet.id
  multi_az             = false
  db_name              = "mydb"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  username             = "mydb"
  password             = "asdf!234"
  #parameter_group_name = "default.mysql5.7"
  skip_final_snapshot    = true
  vpc_security_group_ids = [aws_security_group.database_sg.id]
}