젠킨스 서버(jenkins-server) 실행

$ docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-server \
-v jenkins_home:/var/jenkins_home \
--net ansible-net                                    \
jenkins/jenkins:lts-jdk11


앤서블 서버(ansible-server) 실행

$ docker run -itd -p 10022:22 --name ansible-server --net ansible-net  -v /var/run/docker.sock:/var/run/docker.sock magiceco/ssh-server:ubuntu
