
resource "local_file" "inventory" {

    depends_on = [
      aws_instance.master,
      aws_instance.worker
    ]

    count       = 2
    content     = "[Master]\n${aws_instance.master.public_ip}\n\n[Worker]\n${aws_instance.worker.public_ip}"
    filename    = "../ansible/hosts"
  }

resource "null_resource" "run-ansible" {

    depends_on = [
      local_file.inventory
    ]

  provisioner "local-exec" {
    command = "echo 'Time to run ansible-playbook'"
    }

  provisioner "local-exec" {
    command = "cd ${var.ansible_path} && ansible-playbook ${var.playbook} -v"
    }

}

