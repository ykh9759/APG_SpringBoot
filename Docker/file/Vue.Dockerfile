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

#nodejs lts버전 설치
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash -
RUN apt install -y nodejs

RUN adduser vue
WORKDIR /home/vue

#단축명령어 
RUN ["/bin/bash", "-c", "echo alias ll=\"'ls -l'\" >> /etc/bash.bashrc"]

#sudo권한 부여
RUN ["/bin/bash", "-c", "echo 'vue ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers"]

#소유주 및 그룹 변경
RUN chown -R vue:vue /home/vue

RUN npm install -g @vue/cli

#nginx 설정파일 심볼릭링크 설정
RUN ln -s /etc/nginx/sites-available/vue.vhost.conf /etc/nginx/sites-enabled/vhost.conf

#nginx 기존 심볼릭링크 삭제
RUN rm /etc/nginx/sites-enabled/default

RUN systemctl enable nginx