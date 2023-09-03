terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

resource "docker_image" "jenkins" {
  name         = "jenkins:lts-jdk11"
  keep_locally = false
}

resource "docker_container" "jenkins-server" {
  image = docker_image.jenkins.image_id
  name  = "tutorial"
  ports {
    internal = 8080
    external = 8080
  }
}
