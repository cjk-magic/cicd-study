FROM docker:stable-dind

RUN apk add --update --no-cache openssh util-linux openrc curl libc6-compat
RUN sed -ri 's/^#?PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config 
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g'                    /etc/ssh/sshd_config  
RUN echo -n 'root:1234' | chpasswd
RUN curl -o /usr/local/bin/minikube -sSL https://github.com/kubernetes/minikube/releases/download/v1.29.0/minikube-linux-amd64
RUN chmod a+x /usr/local/bin/minikube
COPY kube-node-setup.sh /root/setup.sh
RUN chmod a+x /root/setup.sh 



