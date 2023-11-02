# Create an SSH key
resource "tls_private_key" "k8s" {
  algorithm = "RSA"
  rsa_bits  = 4096
}
# Create local key
resource "local_file" "keyfile" {
    content         = tls_private_key.k8s.private_key_pem
    filename        = "../.aws/key_pairs/k8s.pem"
    file_permission = "0400"
}