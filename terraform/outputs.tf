output "keyname" {
  description = "Print out the key pair name"
  value       = module.aws-k8s.keyname
  
}

output "Master_IP" {
  description = "Print out master node IP"
  value       = module.aws-k8s.Master_Node_IP
  
}

output "Worker_IP" {
  description = "Print out worker nodes IPs"
  value       = module.aws-k8s.Worker_Node_IP
  
}

