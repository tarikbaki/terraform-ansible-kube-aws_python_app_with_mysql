module "aws-k8s" {
  source = "./modules/aws-k8s"
  # Pass variables to the module
  region = var.region
  availability_zone = var.availability_zone
  instance_type = var.instance_type
  ansible_path = var.ansible_path
  playbook = var.playbook
  #####
}


