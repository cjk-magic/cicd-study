resource "terraform_data" "host_provisioner" {

  provisioner "remote-exec" {
      script = "./script/ansible.sh"
      connection {
        type = "ssh"
        user = "root"
        password = "xxx"
        host = "xxx.XXX.XXX.XXX"
      }
  }
}
