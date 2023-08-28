FROM docker

RUN apk add --update --no-cache openssh util-linux openrc curl libc6-compat sudo
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config 
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g'                    /etc/ssh/sshd_config  
RUN echo -n 'root:1234' | chpasswd
COPY kube-node-setup.sh /root/setup.sh
COPY bashrc /root/
RUN chmod a+x /root/setup.sh 