#!/bin/sh
docker network create ansible-net 
docker run -itd --name ansible-server --net ansible-net -p 10022:22 magiceco/ssh-server:ubuntu
docker run -itd --name ansible-node1 --net ansible-net -p 20022:22 magiceco/ssh-server:ubuntu
docker run -itd --name ansible-node2 --net ansible-net -p 30022:22 magiceco/ssh-server:ubuntu
docker run --privileged -itd --name ansible-node3 --net ansible-net -p 40022:22 -p 80:80 magiceco/ssh-server:centos7
