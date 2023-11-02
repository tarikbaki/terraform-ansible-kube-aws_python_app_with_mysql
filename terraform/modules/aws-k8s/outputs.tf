output "keyname" {
  description = "Print out the key pair name"
  value       = aws_key_pair.k8s.key_name
  
}

output "Master_Node_IP" {
  value = aws_instance.master.public_ip
}

output "Worker_Node_IP" {
  value = join(", ", aws_instance.worker.*.public_ip)
}