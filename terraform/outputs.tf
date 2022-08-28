output "instance_id" {
    description = "ID of the EC2 instance"
    value = aws_instance.app_server.id
}

output "instance_public_ip" {
    description = "Public IP address of the EC2 instance"
    value = aws_instance.app_server.public_ip
}

output "private_key" {
  value     = tls_private_key.tls_rsa_private_key.private_key_pem
  sensitive = true
}
