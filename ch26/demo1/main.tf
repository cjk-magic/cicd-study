provider "ncloud" {
  support_vpc = true
  region      = "KR"
  access_key  = var.access_key
  secret_key  = var.secret_key
}

resource "ncloud_vpc" "vpc" {
    ipv4_cidr_block = "10.0.0.0/16"
}

resource "ncloud_subnet" "pub-sub" {  
  vpc_no         = ncloud_vpc.vpc.id
  subnet         = "10.0.1.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_vpc.vpc.default_network_acl_no
  subnet_type    = "PUBLIC"
}

resource "ncloud_public_ip" "public_ip" {
  server_instance_no = ncloud_server.server.id
}

resource "ncloud_login_key" "key" {
  key_name = "ncp-token-key"
}

resource "ncloud_server" "server" {
  subnet_no                 = ncloud_subnet.pub-sub.id
  name                      = "my-tf-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050"
  login_key_name            = ncloud_login_key.key.key_name
}

data "ncloud_root_password" "pwd" {
  server_instance_no = ncloud_server.server.id 
  private_key = ncloud_login_key.key.private_key
}

resource "null_resource" "host_provisioner" {

  provisioner "file" {
      source = "scripts/"
      destination = "/root/"
      connection {
        type = "ssh"
        user = "root"
        password = data.ncloud_root_password.pwd.root_password
        host = ncloud_public_ip.public_ip.public_ip
      }
  }

  provisioner "remote-exec" {
     scripts = [ "./scripts/docker-setup.sh", 
                 "./scripts/ansible.sh",
                 "./scripts/script.sh"] 

      connection {
         type = "ssh"
        user = "root"
        password = data.ncloud_root_password.pwd.root_password
        host = ncloud_public_ip.public_ip.public_ip
      }
  }
}
