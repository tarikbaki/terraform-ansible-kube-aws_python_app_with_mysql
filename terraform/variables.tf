variable "region" {
  type = string
  default = "eu-west-1"
}
variable "availability_zone" {
  type = string
  default = "eu-west-1a"
}
variable "instance_type" {
  type = string
  default = "t2.micro"
}

variable "ansible_path" {
  type = string
  default = "../ansible"
}
variable "playbook" {
  type = string
  default = "playbook.yml"
}