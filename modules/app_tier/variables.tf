variable "vpc_id" {
  description = "the vpc id of which the app is launched"
}

variable "gateway_id" {
  description = "the gateway id of which the app is launched"
}

variable "name-app" {
  description = "variable name"
}

variable "ami-id-app" {
  description = "ami of app set in main variables"
}

variable "db-instance-ip" {
  description = "ip of db instance"
}
