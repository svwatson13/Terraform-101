# Set a provider
provider "aws" {
  region = "eu-west-1"
}

# create vpc
resource "aws_vpc" "app_vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = var.name-app
  }
}

# Internet Gateway
resource "aws_internet_gateway" "app_IG" {
  vpc_id = aws_vpc.app_vpc.id

  tags = {
    Name = "${var.name-app} - IG"
  }
}

# Call module to create app_tier
module "app" {
  source = "./modules/app_tier"
  vpc_id = aws_vpc.app_vpc.id
  gateway_id = aws_internet_gateway.app_IG.id
  db-instance-ip = module.db.db-instance-ip
  name-app = var.name-app
  ami-id-app = var.ami-id-app
}

# Call modules to create db_tier
module "db" {
  source = "./modules/db_tier"
  name-db = var.name-db
  vpc_id = aws_vpc.app_vpc.id
  app_security_group_id = module.app.app_security_group_id
  ami-id-db = var.ami-id-db
}
