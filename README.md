Kubernetes Cluster Setup in AWS with Terraform and Ansible
===
Technologies used and why:
---
- __Terraform__: This is the most popular 'Infrastructure as code' technology, compatible with many cloud providers, excellent documentation and huge community. My favourite thing about this technology is that it keeps a state of your infrastructure, which means that you can easily create or destroy everything with a command only.
- __Ansible__: This is a technology that once you get started, you can't let go.
Compatible also with many cloud providers, uses SSH to setup environments instantly.
- __AWS__: The most pupular Cloud provider with incredible services, used and trusted by the biggest companies in the world. Also very easy to handle with Terraform, Ansible and Linux.
- __Kubernetes__: The best orchestration tool..enough said

_Note: Ansible can also provide aws infrastructure but with terraform is easier and more useful because u can immediatelly alternate/destroy your environment just by changing the code._

---
Project Tree
---
```
tree . -aL 3
# -a: show hidden dirs, -L 3: Depth
.
├── ansible
│   ├── ansible.cfg
│   ├── playbook.yml
│   └── roles
│       ├── configure-network-rules
│       ├── deploy-k8s
│       ├── disable-swap
│       ├── install-packages
│       └── join-cluster
├── .aws
│   ├── credentials
│   │   └──creds
│   └── key_pairs
├── README.md
└── terraform
    ├── main.tf
    ├── modules
    │   └── aws-k8s
    ├── outputs.tf
    ├── README.md
    ├── .terraform
    │   ├── modules
    │   └── providers
    ├── .terraform.lock.hcl
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
```
In the tree above, you can see 3 main dirs:
- __ansible__: Hosts the main playbook, the configuration file and the roles. Each role is like a separate module that run its own tasks. For example, you can create an ansible role with:
```
ansible-galaxy init install-packages
```
import it to your main playbook and deploy it in hosts of your favour.
```
- name: Install kubernetes,docker packages
  hosts: all
  remote_user: ubuntu
  roles: 
   - install-packages
```
- __.aws__: This directory keeps the credentials and the key pairs for our provider. Terraform uses this directory for authentication in the provider and for saving the ssh-key-pairs it creates. Ansible uses this directory's key-pairs to connect to the hosts via ssh.

- __terraform__: Same structure as ansible. It has a main file (main.tf) which imports modules hosted beneath the directory. Our module here is the aws-k8s which does the following tasks:

Project Flow (with commands)
---
Since this is a git repository and has to be lightweight, .gitignore contains the following directories and files which you have to create.
- .aws/
- .terraform/
- .terraform* files
- terraform.tfstate* files
```
---------------------------
# 1. Create .aws directory and subfolders as in the tree above
mkdir .aws
cd .aws && mkdir credentials key_pairs 
cd credentials && touch creds
### creds file should look like this
[your aws profile name]
aws_access_key_id={add your access key}
aws_secret_access_key={add your secret access key}
### If you don't have yet your aws keys you can create them in AWS Console
---------------------------
# 2. Initialize terraform environment
cd terraform 
terraform init 
# terraform install installs the packages and providers 
# according to your main.tf file
---------------------------
# 3. Deploy Kubernetes Cluster in AWS
cd terraform
terraform apply
#### But what does terraform apply does?
# 'terraform apply' scans the main.tf file under the folder terraform 
# which imports the module aws-k8s and assigns the necessary variables 
# the module depends on.
# The aws-k8s module:
# - creates a key pair for our cluster and saves it under .aws/key_pairs directory
# - creates VPC, Subnet, Security Group etc. 
# - creates 2 AWS EC2 instances (1 master, 1 worker) and after that
# - creates a hosts file(ansible inventory) under ansible directory with the IPs of the instances filled.
# - applies the ansible playbook in the new instances
# - this ansible playbook installs all the required packages and deploys the kubernetes cluster in our AWS infrastructure
---------------------------
# 4. Connect to master node and view the cluster
(find master ip at hosts file or terraform output)
ssh -i .aws/key_pairs/k8s.pem ubuntu@{MASTER_IP}
kubectl get nodes
# View and Expose your Helm chart
# In this case we deploy a simple traefik helm chart
kubectl get services
kubectl port-forward $(kubectl get pods --selector "app.kubernetes.io/name=traefik" --output=name) 9000:9000 --address='0.0.0.0'

# 5. Open your browser and view the traefik dashboard
http://{MasterIP}:9000/dashboard/#
```
Kubernetes Cluster on AWS How to:
---
1. [Configure Networking and Install Packages](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/install-kubeadm/)
2. [Configure cgroup](https://kubernetes.io/docs/tasks/administer-cluster/kubeadm/configure-cgroup-driver/) _Important dependency for kubelet, easiest practice with docker_
3. [AWS security group rules for k8s cluster](https://kubernetes.io/docs/reference/ports-and-protocols)

Helpful sources
---
[k8s cluster with ansible](https://ugurakgul.medium.com/bootstrapping-a-kubernetes-cluster-with-ansible-2d1a1155fcb9)
