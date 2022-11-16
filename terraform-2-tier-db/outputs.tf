output "alb_dns_name" {
  value = aws_lb.external_alb.dns_name
}

output "db_connection_string" {
  value = "server=${aws_db_instance.rds_mysql_db.address}; database=mydb; Uid=mydb; Pwd=asdf!234"
}