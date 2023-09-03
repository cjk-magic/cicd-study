terraform {
  required_providers {
    docker = {
      source = "kreuzwerker/docker"
      version = "~> 3.0.1"
    }
  }
}

provider "docker" {}

data "docker_registry_image" "jenkins" {
  name = "jenkins/jenkins:lts-jdk11"
}

resource "docker_image" "jenkins" {
  name          = data.docker_registry_image.jenkins.name
  pull_triggers = [data.docker_registry_image.jenkins.sha256_digest]
}

resource "docker_container" "jenkins-server" {
  image = docker_image.jenkins.image_id
  name  = "jenkins-server"
  ports {
    internal = 8080
    external = 8080
  }
  ports {
    internal = 50000
    external = 50000
  }
}
