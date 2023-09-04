resource "terraform_data" "host_provisioner" {

  provisioner "remote-exec" {
      scripts = [ "./scripts/script1.sh", "./scripts/script2.sh"] 
      connection {
        type = "ssh"
        user = "root"
        password = "xxxx"
        host = "xxx.xxx.xxx.xxx"
      }
  }
}
