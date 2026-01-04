resource "aws_vpc" "myvpc" {
    cidr_block = "10.0.0.0/16"
    enable_dns_hostnames = true
    enable_dns_support = true

    tags = {
      Name = "${var.prefix_env}-VPC"
    }
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
    
    tags = {
      Name = "${var.prefix_env}-igw"
    }
}

resource "aws_route_table" "myapp-rt" {
    vpc_id = aws_vpc.myvpc.id

    tags = {
      Name = "${var.prefix_env}-rt"
    }
}

resource "aws_route" "myapp_rt" {
    gateway_id = aws_internet_gateway.igw.id
    route_table_id = aws_route_table.myapp-rt.id
    destination_cidr_block = "0.0.0.0/0"  
}

resource "aws_subnet" "myapp-public-subnet" {
    vpc_id = aws_vpc.myvpc.id
    cidr_block = "10.0.10.0/24"
    availability_zone = "us-east-1a"
    map_public_ip_on_launch = true

    tags = {
        Name = "${var.prefix_env}-public-subnet"
    }
}

resource "aws_route_table_association" "public-rta" {
      subnet_id = aws_subnet.myapp-public-subnet.id
      route_table_id = aws_route_table.myapp-rt.id
}

resource "aws_security_group" "web-sg" {
    vpc_id = aws_vpc.myvpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}