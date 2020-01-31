# Terraform 101

This is our first terraform project
Terraform is an orchestration tool, which will deploy AMIs into the cloud

It can use many providers and use different types of images & or provisioning

In our stack we have:
- Chef - configuration management
- Packer - creates immutable images of our machines

Using a 'main.tf' file we configured a:

- provider
- VPC
- Security Group
- Internet Gateway
- Route Table
- Route Table Associations
- Subnet
- NACL
- Instance
- Shell command to be executed on the instance

# Create NACL
resource "aws_network_acl" "public_" {
  vpc_id = "${aws_vpc.app_vpc.id}"

  egress {
    protocol   = "tcp"
    rule_no    = 200
    action     = "allow"
    cidr_block = "10.0.0.0/24"
    from_port  = 443
    to_port    = 443
  }

  ingress {
    protocol   = "tcp"
    rule_no    = 100
    action     = "allow"
    cidr_block = "10.3.0.0/18"
    from_port  = 80
    to_port    = 80
  }

  tags = {
    Name = "${var.name} - NACL-app"
  }
}

# setting env variables
- cd /home/ubuntu/app
- export DB_HOST=mongodb://<privateipofdb>:27017/posts
- sudo npm install express mongoose ejs
- node app.js
- node seeds/seed.js
