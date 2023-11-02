AWS provisioning and deployment with Ansible 
===========

A terraform module to provide 
- a VPC with its Subnet, Security Group and other network configurations
- an AWS Key Pair for remote ssh connection
- 2 EC2 instances
    - 1 x Master
    - 1 x Worker

    in AWS
    
&&

- a local ansible inventory with the new EC2 IPs
- a local-exec of an ansible playbook


This module can be used for 
- initialization and management of a basic AWS infrastructure
- deploy ansible-playbooks in this infrastructure

Module Input Variables
----------------------

- `region` - region which our aws infrastructure uses
- `credentials_file` - path to our aws credentials
- `profile` - profile name in aws(must match with the one in our credentials file)
- `availability_zone` - same as region (e.g. us-east-2a)
- `instance_type` - t2.micro etc.
- `ansible_path` - path with the playbook location
- `playbook` - playbook filename

Usage
-----

```hcl
module "aws-k8s" {

  source = "./modules/aws-k8s"

  
  region = var.region
  credentials_file = var.credentials_file
  profile = var.profile
  availability_zone = var.availability_zone
  instance_type = var.instance_type
  ansible_path = var.ansible_path
  playbook = var.playbook
  
}
```

_You can find an example of this module use [here]()_ 


Outputs
=======

 - `keyname` - filename of aws keypair
 - `Public IPs` - Master and Worker Public IPs


Authors
=======
