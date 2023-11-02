terraform {
  required_version = ">=1.0.9"
}


# Provide EC2 key pair
resource "aws_key_pair" "k8s" {
  key_name   = "k8s_key_by_terraform"
  public_key = tls_private_key.k8s.public_key_openssh
}


resource "aws_instance" "master" {
    ami = "ami-0694d931cee176e7d"  # ubuntu ami
    instance_type = "t2.medium"  # use t2.medium for better kubernetes management
    availability_zone = var.availability_zone
    key_name = aws_key_pair.k8s.id  # note: you can also create a key pair for ssh connection to instances EC2-> NETWORK AND SECURITY->KEY PAIRS
    associate_public_ip_address = true
    subnet_id             = aws_subnet.my-subnet.id
    vpc_security_group_ids      = [ aws_security_group.master-security-group.id ] 
    tags = {
        Name = "Master"
    }
    user_data = "${file("./modules/aws-k8s/set_master_hostname.sh")}"
}
resource "aws_instance" "worker" {
    ami = "ami-0694d931cee176e7d" # ubuntu ami
    instance_type = var.instance_type
    availability_zone = var.availability_zone
    key_name = aws_key_pair.k8s.id 
    associate_public_ip_address = true
    subnet_id             = aws_subnet.my-subnet.id
    vpc_security_group_ids      = [ aws_security_group.worker-security-group.id ] 
    tags = {
        Name = "Worker"
    }
    user_data = "${file("./modules/aws-k8s/set_worker_hostname.sh")}"
}