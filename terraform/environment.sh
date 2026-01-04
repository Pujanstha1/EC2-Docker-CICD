#!/bin/bash
sudo yum update -y
sudo yum install -y docker
systemctl start docker
systemctl enable docker 
usermod -aG docker ec2-user 

docker --version