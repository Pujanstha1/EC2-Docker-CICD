resource "aws_instance" "web-server" {
    ami = "ami-068c0051b15cdb816"
    instance_type = "t3.micro"
    subnet_id = var.subnet_id
    vpc_security_group_ids = [var.web-sg]
    key_name = "tf-key"

    tags = {
      Name = "${var.prefix_env}-server"
    }
    
    user_data = var.user_data
}

