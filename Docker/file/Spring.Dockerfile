# 우분투 기반 이미지를 선택합니다.
FROM ubuntu:22.04

ENV TZ=Asia/Seoul

# 패키지 업데이트 및 필요한 패키지 설치
RUN apt update
RUN apt install -y vim
RUN apt install -y net-tools
RUN apt install -y sudo
RUN apt install -y curl
RUN apt install -y telnet
RUN apt install -y init systemd
RUN apt install -y openjdk-17-jdk
RUN apt install -y rdate tzdata

RUN adduser spring
WORKDIR /home/spring

#단축명령어 
RUN ["/bin/bash", "-c", "echo alias ll=\"'ls -l'\" >> /etc/bash.bashrc"]

#sudo권한 부여
RUN ["/bin/bash", "-c", "echo 'spring ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"]

#소유주 및 그룹 변경
RUN chown -R spring:spring /home/spring

