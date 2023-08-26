* 도커 네트워크 생성 → docker network create ansible-net

* 젠킨스 서버(jenkins-server) 실행
$ docker run -d -p 8080:8080 -p 50000:50000 
   --name  jenkins-server                    \
   -v jenkins_home:/var/jenkins_home         \
   --net ansible-net                         \
   jenkins/jenkins:lts-jdk11

* 앤서블 서버(ansible-server) 실행
$ docker run -d -p 10022:22 --name ansible-server \
   --net ansible-net                              \
   magiceco/ssh-server:ubuntu       

* 쿠버네티스 서버(kube-node) 실행
$ docker run --privileged -d -p 20022:22 \
    --net ansible-net                    \
    --name kube-node magiceco/kube-node
                           
* 도커 이미지 빌드
docker build -t magiceco/kube-node .
