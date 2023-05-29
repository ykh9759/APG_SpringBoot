# 우분투 기반 이미지를 선택합니다.
FROM ubuntu:22.04

# 패키지 업데이트 및 필요한 패키지 설치
RUN apt update
RUN apt install -y vim
RUN apt install -y net-tools
RUN apt install -y nginx
RUN apt install -y sudo
RUN apt install -y curl
RUN apt install -y telnet
RUN apt install -y init systemd


RUN adduser springboot
WORKDIR /home/springboot


RUN ["/bin/bash", "-c", "echo alias ll=\"'ls -l'\" >> /etc/bash.bashrc"]
RUN ["/bin/bash", "-c", "echo 'vue ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"]

RUN chown -R springboot:springboot /home/springboot


#nginx vhost설정파일 복사
COPY spring.vhost.conf /etc/nginx/sites-available/

RUN ln -s /etc/nginx/sites-available/spring.vhost.conf /etc/nginx/sites-enabled/vhost.conf

CMD ["nginx", "-g", "daemon off;"]