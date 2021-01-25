FROM alpine:3.13

# 時區設定 alpine
RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk update && apk upgrade && \
    apk add --no-cache tzdata

# 安裝 ansible
RUN apk add ansible=2.10.5-r0