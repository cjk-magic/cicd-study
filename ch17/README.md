젠킨스 서버(jenkins-server) 실행
docker run -d -p 8080:8080 -p 50000:50000 --name jenkins-server   \
-v jenkins_home:/var/jenkins_home                                 \
--net ansible-net                                                 \
jenkins/jenkins:lts-jdk11


앤서블 서버(ansible-server) 실행
docker run -itd -p 10022:22 --name ansible-server                \
--net ansible-net                                                \
magiceco/ssh-server:ubuntu


앤서블 노드1(ansible-node1) 실행
docker run -itd -p 20022:22 -p 9090:8080                         \
--net ansible-net  --name ansible-node1                          \
magiceco/ssh-tomcat9
