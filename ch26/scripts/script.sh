#!/bin/sh
# network 생성
docker network create ansible-net 
# 젠킨스(Jenkins-server) 생성
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-server -v jenkins_home:/var/jenkins_home --net ansible-net jenkins/jenkins:lts-jdk11
# 앤서블(Ansible-server) 생성
docker run -itd -p 10022:22 --name ansible-server --net ansible-net -v /var/run/docker.sock:/var/run/docker.sock magiceco/ssh-server:ubuntu
# 쿠버네티스 서버(kube-node) 실행
docker run --privileged -d -p 20022:22 -p 8001:8001  --name kube-node --net ansible-net   magiceco/kube-node