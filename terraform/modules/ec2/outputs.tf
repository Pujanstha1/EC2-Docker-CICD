output "public_ip" {
    description = "Server Public IP"
    value = aws_instance.web-server.public_ip
}