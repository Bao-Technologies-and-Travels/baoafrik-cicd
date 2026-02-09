output "instance_id" { value = aws_instance.staging_server.id }
output "public_ip" { value = aws_instance.staging_server.public_ip }
output "private_ip" { value = aws_instance.staging_server.private_ip }
