# Credentials
variable "access_key" {}
variable "secret_key" {}
variable "token" {}
variable "aws_key_pair" {}

# instance 
variable "username" {}
variable "aws-ami" {}
variable "instance_type" {}
variable "security_group_id" { type = "list" }

# storage
variable "storage_size" {}

# location
variable "region" {
  default = "eu-central-1"
}
variable "az" {
  default = "eu-central-1a"
}