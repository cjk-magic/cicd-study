#!/bin/sh
mkdir /run/openrc
touch /run/openrc/softlevel
rc-update add sshd default
rc-status default
rc-service sshd start

curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

minikube start --force
minikube kubectl get nodes
# alias kubectl="minikube kubectl"
# kubectl get nodes

