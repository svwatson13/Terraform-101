output "db-instance-ip" {
  value = aws_instance.db_instance.private_ip
}
