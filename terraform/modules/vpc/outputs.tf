output "subnet_id" {
    description = "Public Subnet ID"
    value = aws_subnet.myapp-public-subnet.id  
}

output "web-sg" {
    description = "Web Security Groups"
    value = aws_security_group.web-sg.id  
}