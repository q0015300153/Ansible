FROM php:8.0-fpm

# 時區設定
RUN apt-get update -y && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends tzdata

RUN TZ=Asia/Taipei && \
    ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone && \
    dpkg-reconfigure -f noninteractive tzdata

# 安裝套件
RUN apt-get update -y && \
    apt-get install -y git zip zlib1g-dev libzip-dev sqlite3 libsqlite3-dev
RUN docker-php-ext-install zip pdo pdo_mysql pdo_sqlite

# 安裝 composer
#RUN pecl install uopz # 暫時不支援 PHP8
RUN curl --silent --show-error https://getcomposer.org/installer | php && \
    mv composer.phar /usr/local/bin/composer

ENV PATH                     $PATH:/root/.composer/vendor/bin
ENV COMPOSER_ALLOW_SUPERUSER 1
RUN composer global require laravel/installer