#
# PHP7.4.3 + NGINX + Supervisor + Composer
#

FROM php:7.4.3-fpm-alpine3.10

RUN  echo "http://mirrors.ustc.edu.cn/alpine/v3.10/main/" > /etc/apk/repositories

RUN apk update &&apk add nginx supervisor \
        && apk add gd zlib-dev libpng-dev  libjpeg-turbo-dev freetype-dev  oniguruma oniguruma-dev nano   \
		&& mkdir /run/nginx  /var/log/supervisor 

RUN  docker-php-ext-configure gd --with-jpeg --with-freetype  \
    && docker-php-ext-install gd pdo_mysql mbstring  bcmath  iconv json \
    && docker-php-ext-enable gd  pdo_mysql mbstring bcmath  iconv  json

COPY  service.conf /etc/supervisor.d/
COPY  default.conf /etc/nginx/conf.d/
COPY  supervisord.conf /etc/
COPY  composer /usr/bin/
COPY  php.ini /usr/local/etc/php/

EXPOSE 80
VOLUME /var/www/html /var/log 


ENTRYPOINT ["/usr/bin/supervisord", "-n", "-c", "/etc/supervisord.conf"]
