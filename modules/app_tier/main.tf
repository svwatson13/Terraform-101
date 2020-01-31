# Main for app tier
# Place all that concerns the app tier in here

# Create subnet
resource "aws_subnet" "app_subnet" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.0.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    name = var.name-app
  }
}

# Route table
resource "aws_route_table" "app_route" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.gateway_id
  }

  tags = {
  # this tag calls the variable and interpolates with the word route
    name = "${var.name-app} - route"
  }
}

# Route table assocations
resource "aws_route_table_association" "app_route_association" {
  subnet_id = aws_subnet.app_subnet.id
  route_table_id = aws_route_table.app_route.id
}

# Create security group
resource "aws_security_group" "app_security" {
  name        = var.name-app
  description = "Allow port 80"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 3000
    to_port         = 3000
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.name-app
  }
}

# Send template sh file
data "template_file" "app_init" {
  template = "${file("./scripts/init_script.sh.tpl")}"
  vars = {
    db-ip=var.db-instance-ip
  }
}

# Launch an instance
resource "aws_instance" "app_init" {
  ami           = var.ami-id-app
  subnet_id     = aws_subnet.app_subnet.id
  vpc_security_group_ids = [aws_security_group.app_security.id]
  instance_type = "t2.micro"
  associate_public_ip_address = true
  user_data = data.template_file.app_init.rendered
  tags = {
    Name = var.name-app
  }
}
