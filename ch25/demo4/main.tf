resource "terraform_data" "host_provisioner" {

  provisioner "remote-exec" {
      script = "./script/ansible.sh"
      connection {
        type = "ssh"
        user = "root"
        password = "U3DH@maDT%Ti"
        host = "223.130.161.27"
      }
  }
}
