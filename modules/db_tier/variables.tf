variable "app_security_group_id" {
  description = "security group id from app"
}

variable "vpc_id" {
  description = "the vpc id of which the db is launched"
}

variable "name-db" {
  description = "variable name"
}

variable "ami-id-db" {
  description = "ami of db set in main variables"
}
