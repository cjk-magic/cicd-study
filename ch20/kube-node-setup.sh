#!/bin/sh
rc-update add sshd
rc-service sshd start
touch /run/openrc/softlevel
rc-service sshd start

minikube start --force
minikube kubectl get nodes
alias kubectl="minikube kubectl"
#kubectl get nodes

