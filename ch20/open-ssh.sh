#!/bin/sh
apk add --update --no-cache openssh openrc
sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config 
sed -ri 's/UsePAM yes/#UsePAM yes/g'                    /etc/ssh/sshd_config  
echo -n 'root:1234' | chpasswd
touch /run/openrc/softlevel
rc-update add sshd
rc-service sshd start