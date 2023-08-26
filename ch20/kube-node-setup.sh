#!/bin/sh
mkdir /run/openrc
touch /run/openrc/softlevel
rc-update add sshd default
rc-status default
rc-service sshd start

minikube start --force
minikube kubectl get nodes
# alias kubectl="minikube kubectl"
# kubectl get nodes

