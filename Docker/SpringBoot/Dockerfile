# 우분투 기반 이미지를 선택합니다.
FROM ubuntu:22.04

# 패키지 업데이트 및 필요한 패키지 설치
RUN apt update
RUN apt install -y vim
RUN apt install -y net-tools
RUN apt install -y nginx
RUN apt install -y openjdk-17-jdk


RUN adduser springboot
WORKDIR /home/springboot

CMD ["nginx", "-g", "daemon off;"]

RUN ["/bin/bash", "-c", "chown -R springboot:springboot /home/springboot"]

USER springboot

# 명령어 단축
RUN ["/bin/bash", "-c", "echo alias ll=\"'ls -l'\" >> /home/springboot/.bashrc"]
RUN ["/bin/bash", "-c", "echo alias vi=\"'vim'\" >> /home/springboot/.bashrc"]