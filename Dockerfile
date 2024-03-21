FROM ubuntu:22.04

# 환경 변수 및 라벨 정의
LABEL website="sangchul.kr"

ARG SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD:-root}
ENV SSH_ROOT_PASSWORD=${SSH_ROOT_PASSWORD}
ENV TZ=Asia/Seoul

# 패키지 설치 및 시스템 설정
#RUN sed -i 's/kr.archive.ubuntu.com/mirror.kakao.com/g' /etc/apt/sources.list \
RUN sed -i 's/archive\.ubuntu\.com\|kr\.archive\.ubuntu\.com/mirror.kakao.com/g' /etc/apt/sources.list \
  && apt-get update \
  && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    systemd \
    systemd-sysv \
    build-essential \
    tzdata \
    sudo \
    passwd \
    unzip \
    net-tools \
    dnsutils \
    vim \
    curl \
  && apt-get clean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# systemd 관련 설정
RUN mkdir -p /run/systemd \
  && rm -f /sbin/init

# 표준 시간대 설정
RUN echo $TZ > /etc/timezone

# root 사용자의 비밀번호를 설정하고 bash 프롬프트를 구성
RUN echo "root:$SSH_ROOT_PASSWORD" | chpasswd \
  && echo 'export PS1="\[\e[33m\]\u\[\e[m\]\[\e[37m\]@\[\e[m\]\[\e[34m\]\h\[\e[m\]:\[\033[01;31m\]\W\[\e[m\]$ "' >> ~/.bashrc

# SSH 서버 설정
RUN sed -i 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config \
  && sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config

# systemd를 시작하는 CMD 명령
CMD ["/lib/systemd/systemd"]
