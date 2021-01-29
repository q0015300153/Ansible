FROM nginx:1.19-alpine AS builder

# 時區設定 alpine
RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk update && apk upgrade && \
    apk add --no-cache tzdata

# 安裝軟體
RUN apk add --no-cache --virtual .build-deps gcc libc-dev make openssl-dev pcre-dev \
    zlib-dev linux-headers curl gnupg libxslt-dev gd-dev geoip-dev && \
    # 下載 nginx 以及 module
    curl "https://nginx.org/download/nginx-${NGINX_VERSION}.tar.gz" -o nginx.tar.gz && \
    curl -L "https://github.com/openresty/headers-more-nginx-module/archive/v0.33.tar.gz" -o headers-more-nginx-module.tar.gz

# 安裝 nginx 以及 module
RUN CONFARGS=$(nginx -V 2>&1 | sed -n -e 's/^.*arguments: //p') \
    CONFARGS=${CONFARGS/-Os -fomit-frame-pointer/-Os} && \
    mkdir -p /usr/src && \
    tar -zxC /usr/src -f nginx.tar.gz && \
    # 解壓縮 module
    tar -xzvf "headers-more-nginx-module.tar.gz" && \
    # 加入 module 編譯
    cd /usr/src/nginx-$NGINX_VERSION && \
    ./configure --with-compat $CONFARGS \
        --add-dynamic-module=/headers-more-nginx-module-0.33 && \
    # 編譯 nginx
    make modules && mv ./objs/*.so /

FROM nginx:1.19-alpine
# 複製編譯好的模組
COPY --from=builder /ngx_http_headers_more_filter_module.so /usr/local/nginx/modules/ngx_http_headers_more_filter_module.so

# 時區設定 alpine
RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk update && apk upgrade && \
    apk add --no-cache tzdata

# 設定 html 料夾
RUN mkdir -p /var/www/html
RUN chmod -R 755 /var/www/html
VOLUME /var/www/html

# 設定 alias 料夾
RUN mkdir -p /etc/nginx/conf.d/alias
RUN chmod -R 755 /etc/nginx/conf.d/alias

# log 檔資料夾
RUN chmod -R 755 /var/log/nginx
VOLUME /var/log/nginx

# 啟動 nginx
EXPOSE 80
STOPSIGNAL SIGTERM
CMD ["nginx", "-g", "daemon off;"]