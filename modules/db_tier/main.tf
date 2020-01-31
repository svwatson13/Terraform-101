# Main for db tier
# Place all that concerns the app tier in here

# Create subnet
resource "aws_subnet" "db_subnet" {
  vpc_id = var.vpc_id
  cidr_block = "10.0.1.0/24"
  availability_zone = "eu-west-1a"
  tags = {
    Name = var.name-db
  }
}

resource "aws_security_group" "db_security" {
  name        = var.name-db
  description = "Allow 27017"
  vpc_id      = var.vpc_id

  ingress {
    from_port       = 27017
    to_port         = 27017
    protocol        = "tcp"
    security_groups = [var.app_security_group_id]
  }
  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    cidr_blocks     = ["212.161.55.68/32"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.name-db
  }
}

# Launch an instance
resource "aws_instance" "db_instance" {
  ami           = var.ami-id-db
  subnet_id     = aws_subnet.db_subnet.id
  vpc_security_group_ids = [aws_security_group.db_security.id]
  instance_type = "t2.micro"
  associate_public_ip_address = true
  tags = {
    Name = var.name-db
  }
}
