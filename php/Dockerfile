FROM php:8.0-fpm-alpine

# 時區設定 alpine
RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    apk update && apk upgrade && \
    apk add --no-cache tzdata

# 安裝套件
RUN apk add --no-cache --virtual .build-deps git libzip-dev zlib-dev sqlite sqlite-dev && \
	# 安裝 php 套件
	docker-php-ext-install zip pdo pdo_mysql pdo_sqlite

# 安裝 composer
ENV PATH $PATH:/root/.composer/vendor/bin
ENV COMPOSER_ALLOW_SUPERUSER 1
#RUN pecl install uopz # 暫時不支援 PHP8
RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer && \
	composer global require laravel/installer && \
	# 複製 php.ini
	cp "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"