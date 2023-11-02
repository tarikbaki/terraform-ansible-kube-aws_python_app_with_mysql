# global variables from root
variable "region" {
  type = string
  description = "aws-region"
}

variable "availability_zone" {
  type = string
  description = "availability zone"
}
variable "instance_type" {
  type = string
  description = "instance type"
}
variable "ansible_path" {
  type = string
  description = "path where ansible playbook exists"
}
variable "playbook" {
  type = string
  description = "playbook filename"
}
############################