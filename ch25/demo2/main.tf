terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "ssh-server" {
  name         = "magiceco/ssh-server:ubuntu"
  keep_locally = false
}

resource "docker_container" "ssh-server" {
  image = docker_image.ssh-server.image_id
  name  = "ssh-demo"
  ports {
    internal = 22
    external = 22
  }

  connection {
    type      = "ssh"
    user      = "root"
    password  = "1234" 
    host      = "127.0.0.1"   
  }

  provisioner "remote-exec" {
    inline = [
      "apt-get update", 
      "apt-get install -y git",
      "cd /root",
      "git clone https://github.com/cjk-magic/docker.git",
      "/bin/sh /root/docker/docker-cli-setup.sh"
    ]
  }
}

