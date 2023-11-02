Deploy existed Terraform module
===========
This directory provides a good-simple abstraction of terraform with modules-variables-outputs.
Find the Terraform module {aws-k8s} beneath this directory
and import it in a main.tf file, like below, in order to deploy it.

Directory Tree
--------------
```
.
├── main.tf
├── modules
│   └── aws-k8s
│       ├── ansible.tf
│       ├── create_user.sh
│       ├── keys.tf
│       ├── main.tf
│       ├── outputs.tf
│       ├── provider.tf
│       ├── README.md
│       ├── security.tf
│       └── variables.tf
├── outputs.tf
├── README.md
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
```

Module Input Variables
----------------------

- `region` - region which our aws infrastructure uses
- `profile` - profile name in aws(must match with the one in our credentials file)
- `availability_zone` - same as region (e.g. eu-west-1a)
- `instance_type` - t2.micro etc.
- `ansible_path` - path with the playbook location
- `playbook` - playbook filename


Example of main.tf, variables.tf, outputs.tf
--------------------------------------------

```hcl
#########
# main.tf
#########
module "aws-k8s" {

  source = "./modules/aws-k8s"

  
  region = var.region
  profile = var.profile
  availability_zone = var.availability_zone
  instance_type = var.instance_type
  ansible_path = var.ansible_path
  playbook = var.playbook
  
}
##############
# variables.tf
##############
variable "region" {
  type = string
  default = "eu-west-1"
}
...
############
# outputs.tf
############
output "keyname" {
  description = "Print out the key pair name"
  value       = module.aws-k8s.keyname
  
}
...
```
---
#### _Notice that in case we want to define variables and catch outputs outside the terraform module, variables and outputs must match with the ones inside the module. For example the variable "region" must be defined in file ./variables.tf but also reffered inside the module in the file {module_name}/variables.tf_
---
Outputs
=======

 - `keyname` - filename of aws keypair
 - `Public IPs` - Master and Worker Public IPs


Authors
=======

tarik125@gmail.com