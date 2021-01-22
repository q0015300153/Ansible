FROM ubuntu:21.04

# 時區設定
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# 安裝 ansible
RUN apt-get update -y && \
	apt-get install -y software-properties-common && \
	apt-add-repository --yes --update ppa:ansible/ansible-2.9 && \
	apt-get install -y ansible
